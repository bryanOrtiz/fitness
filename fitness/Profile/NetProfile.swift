//
//  NetProfile.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/27/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - User Profile

protocol NetUserProfile {
    func getUserProfile() -> DataResponsePublisher<Page<UserProfile>>
}

extension Net: NetUserProfile {
    func getUserProfile() -> DataResponsePublisher<Page<UserProfile>> {
        return session.request(self.baseURL + "userprofile/")
            .validate()
            .publishDecodable(type: Page<UserProfile>.self)
    }
}
