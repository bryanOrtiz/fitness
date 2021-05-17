//
//  Exercise.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/9/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Exercise: Codable {
    let id: Int
    let name: String
    let uuid: String
    let description: String
    let creationDate: String
    let category: Int
    let muscles: [Int]
    let musclesSecondary: [Int]
    let equipment: [Int]
    let language: Int
    let license: Int
    let licenseAuthor: String
    let variations: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case uuid
        case description
        case category
        case muscles
        case equipment
        case language
        case license
        case variations

        case creationDate = "creation_date"
        case musclesSecondary = "muscles_secondary"
        case licenseAuthor = "license_author"
    }
}
