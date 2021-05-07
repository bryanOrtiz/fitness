//
//  Language.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/6/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Language: Codable {

    let shortName: String
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case shortName = "short_name"
        case fullName = "full_name"
    }
}
