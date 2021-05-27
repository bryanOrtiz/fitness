//
//  AppDeps.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/26/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class AppDeps: ObservableObject {

    @Published var isLoggedIn = false

    let net = Net()
    let keychainService = KeychainService()

    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: - State Handlers

    func observeLoginState() {
        net.$interceptor
            .map { inteceptor -> Bool in
                inteceptor != nil ? true : false
            }
            .assign(to: \.isLoggedIn, on: self)
            .store(in: &cancellableSet)
    }

    func storeCredentials() {
        net.$credential
            .flatMap { [unowned self] credential -> AnyPublisher<Void, KeychainWrapperError> in
                guard let credential = credential else {
                    return keychainService.deleteGenericPasswordFor(account: "fitness", service: "retrievePassword")
                }
                return keychainService.storeGenericPasswordFor(account: "fitness",
                                                               service: "retrievePassword",
                                                               password: credential.accessToken)
            }
            .sink { completion in
                switch completion {
                case let .failure(error):
                    debugPrint("error: \(error)")
                case .finished:
                    debugPrint("completed setting credential")
                }
            } receiveValue: { value in
                print("it worked??? \(value)")
            }
            .store(in: &cancellableSet)
    }

    func getCredentials() {
        return keychainService.getGenericPasswordFor(account: "fitness",
                                                     service: "retrievePassword")
            .map { token -> BasicAuthenticationCredential in
                return BasicAuthenticationCredential(accessToken: token)
            }
            .sink { completion in
                switch completion {
                case let .failure(error):
                    debugPrint("error: \(error)")
                case .finished:
                    debugPrint("completed getting credential")
                }
            } receiveValue: { [unowned self] credential in
                debugPrint("credential: \(credential)")
                net.credential = credential
            }
            .store(in: &cancellableSet)
    }

    func logOut() {
        net.credential = nil
    }
}
