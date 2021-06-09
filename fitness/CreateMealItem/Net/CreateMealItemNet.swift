//
//  CreateMealItemNet.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/8/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import Combine

protocol CreateMealItemNet {
    func createMealItem(item: NutritionPlanInfo.Meal.Item) -> DataResponsePublisher<NutritionPlanInfo.Meal.Item>

    func findIngredients(by term: String) -> AnyPublisher<[SearchIngredient], AFError>

    func getDetailedIngredient(id: Int) -> DataResponsePublisher<Ingredient>
}

extension Net: CreateMealItemNet {

    var mealItemURL: String {
        return "\(baseURL)mealitem/"
    }

    func createMealItem(item: NutritionPlanInfo.Meal.Item) -> DataResponsePublisher<NutritionPlanInfo.Meal.Item> {
        return session.request(self.mealItemURL,
                               method: .post,
                               parameters: item,
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: NutritionPlanInfo.Meal.Item.self)
    }

    var ingredientURL: String { "\(self.baseURL)ingredient/" }

    func findIngredients(by term: String) -> AnyPublisher<[SearchIngredient], AFError> {
        return session.request("\(self.ingredientURL)search/",
                               parameters: ["term": term])
            .validate()
            .publishDecodable(type: Suggestions<SearchIngredient>.self)
            .value()
            .map { suggestions -> [SearchIngredient] in
                return suggestions.suggestions?.compactMap({ $0.data }) ?? []
            }
            .eraseToAnyPublisher()
    }

    func getDetailedIngredient(id: Int) -> DataResponsePublisher<Ingredient> {
        return session.request(self.ingredientURL + "\(id)/")
            .validate()
            .publishDecodable(type: Ingredient.self)
    }
}
