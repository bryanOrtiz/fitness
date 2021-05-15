//
//  ExerciseInfo.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/9/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct ExerciseInfo: Codable {
    let id: Int
    let name: String
    let uuid: String
    let description: String
    let creationDate: String
    let category: ExerciseCategory
    let muscles: [Muscle]
    let musclesSecondary: [Muscle]
    let equipment: [Equipment]
    let language: Language
    let license: License
    let licenseAuthor: String
//    let images: [String]
    let comments: [ExerciseComment]
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
//        case images
        case comments
        case variations

        case creationDate = "creation_date"
        case musclesSecondary = "muscles_secondary"
        case licenseAuthor = "license_author"
    }
}
