//
//  NutritionPlan.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/11/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct NutritionPlan: Decodable {
    let id: Int
    let creationDate: String
    let description: String
    let hasGoalCalories: Bool
    let language: Int

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case language

        case creationDate = "creation_date"
        case hasGoalCalories = "has_goal_calories"
    }
}
