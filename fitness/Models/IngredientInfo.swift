//
//  IngredientInfo.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/11/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct IngredientInfo: Codable {

    let id: Int
    let name: String
    let creationDate: String
    let updateDate: String
    let energy: Int
    let protein: Double
    let carbohydrates: Double
    let carbohydratesSugar: Double
    let fat: Double
    let fatSaturated: Double
    let fibres: Double?
    let sodium: Double
    let license: License
    let licenseAuthor: String
//    let ingredientWeightUnitSet: IngredientWeightUnit
    let language: Language

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
//        case ingredientWeightUnitSet = "ingredientweightunit_set"
    }
}
