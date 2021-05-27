//
//  ProfileViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/27/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

import Combine

class ProfileViewModel: ObservableObject {

    // MARK: - Properties
    @Published var profile: UserProfile?
    @Published var net: NetUserProfile!

    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Network

    func getProfile() {
        $net.compactMap({ $0 })
            .flatMap { net in
                return net.getUserProfile()
                    .result()
            }
            .map({ result in
                switch result {
                case let .success(page):
                    return page.results.first
                case let .failure(error):
                    debugPrint("Error: ", error)
                    return nil
                }
            })
            .assign(to: \.profile, on: self)
            .store(in: &cancellableSet)
    }
}
