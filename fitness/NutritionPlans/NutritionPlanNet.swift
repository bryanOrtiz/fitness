//
//  NutritionPlanNet.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/21/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

protocol NetNutritionPlan {
    func getNutritionPlan() -> DataResponsePublisher<Page<NutritionPlan>>
    func createNutritionPlan() -> DataResponsePublisher<NutritionPlan>
}

extension Net: NetNutritionPlan {
    func getNutritionPlan() -> DataResponsePublisher<Page<NutritionPlan>> {
        return session.request(self.baseURL + "/nutritionplan/")
            .validate()
            .publishDecodable(type: Page<NutritionPlan>.self)
    }

    func createNutritionPlan() -> DataResponsePublisher<NutritionPlan> {
        return session.request(self.baseURL + "/nutritionplan/")
            .validate()
            .publishDecodable(type: NutritionPlan.self)
    }
}
