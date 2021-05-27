//
//  LoginViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/25/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

import Combine

class LoginViewModel: ObservableObject {

    // MARK: - Properties
    @Published var token: BasicAuthenticationCredential?

    private var cancellableSet: Set<AnyCancellable> = []

    var net: Net!

    // MARK: - NET

    func login(username: String, password: String) {
        net.login(username: username, password: password)
            .result()
            .map({ [weak self] result in
                guard let self = self else { return nil }
                switch result {
                case let .success(token):
                    self.net.credential = token
                    return token
                case let .failure(error):
                    debugPrint("error: \(error)")
                    return nil
                }
            })
            .assign(to: \.token, on: self)
            .store(in: &cancellableSet)
    }
}
