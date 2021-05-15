//
//  IngredientWeightUnit.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/11/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct IngredeintWeightUnit: Codable {
    let id: Int
    let amount: Double
    let gram: Int
    let ingredient: Int
    let unit: Int
}
