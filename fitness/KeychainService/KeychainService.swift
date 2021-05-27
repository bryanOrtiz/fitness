//
//  KeychainService.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/26/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

// MARK: - KeychainWrapperError
struct KeychainWrapperError: Error {
    var message: String?
    var type: KeychainErrorType

    enum KeychainErrorType {
        case badData
        case servicesError
        case itemNotFound
        case unableToConvertToString
    }

    init(status: OSStatus, type: KeychainErrorType) {
        self.type = type
        if let errorMessage = SecCopyErrorMessageString(status, nil) {
            self.message = String(errorMessage)
        } else {
            self.message = "Status Code: \(status)"
        }
    }

    init(type: KeychainErrorType) {
        self.type = type
    }

    init(message: String, type: KeychainErrorType) {
        self.message = message
        self.type = type
    }
}

// MARK: - KeychainService
class KeychainService: ObservableObject {

    // MARK: - Store
    func storeGenericPasswordFor(
        account: String,
        service: String,
        password: String
    ) -> AnyPublisher<Void, KeychainWrapperError> {
        let passthrough = PassthroughSubject<Void, KeychainWrapperError>()
        if password.isEmpty {
            return deleteGenericPasswordFor(
                account: account,
                service: service)
        }

        guard let passwordData = password.data(using: .utf8) else {
            print("Error converting value to data.")
            passthrough.send(completion: .failure(KeychainWrapperError(type: .badData)))
            return passthrough.eraseToAnyPublisher()
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: passwordData
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            return updateGenericPasswordFor(
                account: account,
                service: service,
                password: password)
        default:
            passthrough.send(completion: .failure(KeychainWrapperError(status: status, type: .servicesError)))
            return passthrough.eraseToAnyPublisher()

        }
        passthrough.send()
        passthrough.send(completion: .finished)
        return passthrough.eraseToAnyPublisher()
    }

    // MARK: - Get

    func getGenericPasswordFor(account: String, service: String) -> AnyPublisher<String, KeychainWrapperError> {
        return Future<String, KeychainWrapperError> { promise in
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecMatchLimit as String: kSecMatchLimitOne,
                kSecReturnAttributes as String: true,
                kSecReturnData as String: true
            ]

            var item: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &item)
            guard status != errSecItemNotFound else {
                promise(.failure(KeychainWrapperError(type: .itemNotFound)))
                return
            }
            guard status == errSecSuccess else {
                promise(.failure(KeychainWrapperError(status: status,
                                                      type: .servicesError)))
                return
            }

            guard
                let existingItem = item as? [String: Any],
                let valueData = existingItem[kSecValueData as String] as? Data,
                let value = String(data: valueData, encoding: .utf8)
            else {
                promise(.failure(KeychainWrapperError(type: .unableToConvertToString)))
                return
            }

            promise(.success(value))
        }.eraseToAnyPublisher()
    }

    // MARK: - Update

    func updateGenericPasswordFor(
        account: String,
        service: String,
        password: String
    ) -> AnyPublisher<Void, KeychainWrapperError> {
        return Future<Void, KeychainWrapperError> { promise in
            guard let passwordData = password.data(using: .utf8) else {
                print("Error converting value to data.")
                promise(.failure(KeychainWrapperError(type: .badData)))
                return
            }

            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service
            ]

            let attributes: [String: Any] = [
                kSecValueData as String: passwordData
            ]

            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            guard status != errSecItemNotFound else {
                promise(.failure(KeychainWrapperError(
                                    message: "Matching Item Not Found",
                                    type: .itemNotFound)))
                return
            }
            guard status == errSecSuccess else {
                promise(.failure(KeychainWrapperError(status: status, type: .servicesError)))
                return
            }
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    // MARK: - Delete

    func deleteGenericPasswordFor(account: String, service: String) -> AnyPublisher<Void, KeychainWrapperError> {
        return Future<Void, KeychainWrapperError> { promise in
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service
            ]

            let status = SecItemDelete(query as CFDictionary)
            guard status == errSecSuccess || status == errSecItemNotFound else {
                promise(.failure(KeychainWrapperError(status: status, type: .servicesError)))
                return
            }
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}
