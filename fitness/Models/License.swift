//
//  License.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct License: Codable {
    let id: Int
    let fullName: String
    let shortName: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, url

        case fullName = "full_name"
        case shortName = "short_name"
    }
}
