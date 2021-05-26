//
//  NetLogin.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/26/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

protocol NetLogin {
    func login(username: String, password: String) -> DataResponsePublisher<BasicAuthenticationCredential>
}

extension Net: NetLogin {
    func login(username: String, password: String) -> DataResponsePublisher<BasicAuthenticationCredential> {
        return AF.request(self.baseURL + "login/",
                          method: .post,
                          parameters: ["username": username, "password": password],
                          encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: BasicAuthenticationCredential.self)
    }
}
