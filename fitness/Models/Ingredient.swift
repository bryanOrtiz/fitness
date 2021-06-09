//
//  Ingredient.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/11/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Ingredient: Codable {
    let id: Int
    let name: String
    let creationDate: String
    let updateDate: String
    let energy: Int
    let protein: String
    let carbohydrates: String
    let carbohydratesSugar: String
    let fat: String
    let fatSaturated: String
    let fibres: String?
    let sodium: String
    let license: Int
    let licenseAuthor: String
    let language: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case energy
        case protein
        case carbohydrates
        case fat
        case fibres
        case sodium
        case license
        case language

        case creationDate = "creation_date"
        case updateDate = "update_date"
        case carbohydratesSugar = "carbohydrates_sugar"
        case fatSaturated = "fat_saturated"
        case licenseAuthor = "license_author"
    }
}
