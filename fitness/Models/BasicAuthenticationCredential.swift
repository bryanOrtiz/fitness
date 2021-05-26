//
//  BasicAuthenticationCredential.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/26/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

struct BasicAuthenticationCredential: Codable, AuthenticationCredential {

    // MARK: - Properties

    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "token"
    }

    // MARK: - AuthenticationCredential

    var requiresRefresh: Bool { false }
}
