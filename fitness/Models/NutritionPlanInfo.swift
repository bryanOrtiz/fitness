//
//  NutritionPlanInfo.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/11/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct NutritionPlanInfo: Decodable {
    /**
     {
                 "get_nutritional_values": {
                     "total": {
                         "energy": 0.0,
                         "protein": 0.0,
                         "carbohydrates": 0.0,
                         "carbohydrates_sugar": 0.0,
                         "fat": 0.0,
                         "fat_saturated": 0.0,
                         "fibres": 0.0,
                         "sodium": 0.0,
                         "energy_kilojoule": 0.0
                     },
                     "percent": {
                         "protein": 0.0,
                         "carbohydrates": 0.0,
                         "fat": 0.0
                     },
                     "per_kg": {
                         "protein": 0.0,
                         "carbohydrates": 0.0,
                         "fat": 0.0
                     }
                 },
             }
     */
    let id: Int
    let creationDate: String
    let description: String
    let language: Language
//    let meals: [Meal]

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case language

        case creationDate = "creation_date"
    }
}
