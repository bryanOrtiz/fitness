//
//  NutritionPlanInfo.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/11/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct NutritionPlanInfo: Codable, Identifiable {

    // MARK: - Language

    struct Language: Codable, Identifiable {
        let id: Int
        let shortName: String
        let fullName: String
    }

    // MARK: - NutritionalValues

    struct NutritionalValues: Codable {
        let total: NutritionalValues.Total
        let percent: Percent
        let perKG: PerKG
    }

    // MARK: - Meal

    struct Meal: Codable, Identifiable {
        let id: Int
        let plan: Int
        let order: Int
        let time: String?
        let items: [NutritionPlanInfo.Meal.Item]!
        let total: NutritionalValues.Total!
    }

    // MARK: - Properties

    let id: Int
    let creationDate: String
    let description: String
    let nutritionalValues: NutritionalValues
    let language: NutritionPlanInfo.Language
    let meals: [NutritionPlanInfo.Meal]

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case language

        case creationDate = "creation_date"
        case meals
        case nutritionalValues = "get_nutritional_values"
    }
}

// MARK: - NutritionalValues sub models

extension NutritionPlanInfo.NutritionalValues {

    enum CodingKeys: String, CodingKey {
        case total
        case percent
        case perKG = "per_kg"
    }

    // MARK: - Total

    struct Total: Codable {
        let energy: Double
        let protein: Double
        let carbohydrates: Double
        let carbohydratesSugar: Double
        let fat: Double
        let fatSaturated: Double
        let fibres: Double
        let sodium: Double
        let energyKilojoule: Double
    }

    // MARK: - Percent

    struct Percent: Codable {
        let protein: Double
        let carbohydrates: Double
        let fat: Double
    }

    // MARK: - PerKG

    struct PerKG: Codable {
        let protein: Double
        let carbohydrates: Double
        let fat: Double
    }
}

extension NutritionPlanInfo.NutritionalValues.Total {

    // MARK: - Total CodingKeys

    enum CodingKeys: String, CodingKey {
        case energy
        case protein
        case carbohydrates
        case carbohydratesSugar = "carbohydrates_sugar"
        case fat
        case fatSaturated = "fat_saturated"
        case fibres
        case sodium
        case energyKilojoule = "energy_kilojoule"
    }
}

// MARK: - NutritionPlanInfo.Meal sub models

extension NutritionPlanInfo.Meal {

    // MARK: - Item

    struct Item: Codable, Identifiable {
        let id: Int
        let mealId: Int
        let ingredientId: Int
        let ingredient: NutritionPlanInfo.Meal.Item.Ingredient
        let weightUnit: String?
        let weightUnitObj: String?
        let order: Int
        let amount: String
    }

    // MARK: - Meal CodingKeys

    enum CodingKeys: String, CodingKey {
        case id
        case plan
        case order
        case time
        case items = "meal_items"
        case total = "get_nutritional_values"
    }

    // MARK: - Changes
    func time(time: String) -> NutritionPlanInfo.Meal {
        NutritionPlanInfo.Meal(id: self.id,
                               plan: self.plan,
                               order: self.order,
                               time: time,
                               items: self.items,
                               total: self.total)
    }
}

extension NutritionPlanInfo.Meal.Item {

    // MARK: - Ingredient

    struct Ingredient: Codable, Identifiable {
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
        let license: License
        let licenseAuthor: String
        let language: NutritionPlanInfo.Language
    }

    // MARK: - Item CodingKeys

    enum CodingKeys: String, CodingKey {
        case id
        case mealId = "meal"
        case ingredientId = "ingredient"
        case ingredient = "ingredient_obj"
        case weightUnit = "weight_unit"
        case weightUnitObj = "weight_unit_obj"
        case order
        case amount
    }
}

extension NutritionPlanInfo.Meal.Item.Ingredient {

    // MARK: - Ingredient CodingKeys

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

extension NutritionPlanInfo.Language {

    // MARK: - Language CodingKeys

    enum CodingKeys: String, CodingKey {
        case id
        case shortName = "short_name"
        case fullName = "full_name"
    }
}
