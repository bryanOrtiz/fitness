//
//  Net.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/3/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Alamofire
import Combine

struct Net {
    
    let authorization = HTTPHeader.authorization("Token de69a1643b4f99be3fb7387f26aab4cd19f9d73e")
    
    func getUserProfile() -> AnyPublisher<UserProfile, AFError> {
        let headers: HTTPHeaders = [
            authorization
        ]
        return AF.request("https://wger.de/api/v2/userprofile/", headers: headers)
            .publishDecodable(type: UserProfile.self)
            .value()
    }
}
