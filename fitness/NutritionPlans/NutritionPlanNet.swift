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
    func getNutritionPlans() -> DataResponsePublisher<Page<NutritionPlan>>
    func createNutritionPlan(plan: NutritionPlan) -> DataResponsePublisher<NutritionPlan>
    func updateNutritionPlan(plan: NutritionPlan) -> DataResponsePublisher<NutritionPlan>
    func deleteNutritionPlan(plan: NutritionPlan) -> DataResponsePublisher<Data>
}

extension Net: NetNutritionPlan {

    var nutritionPlanURL: String { "\(self.baseURL)nutritionplan/" }

    func getNutritionPlans() -> DataResponsePublisher<Page<NutritionPlan>> {
        return session.request(self.nutritionPlanURL)
            .validate()
            .publishDecodable(type: Page<NutritionPlan>.self)
    }

    func createNutritionPlan(plan: NutritionPlan) -> DataResponsePublisher<NutritionPlan> {
        return session.request(self.nutritionPlanURL,
                               method: .post,
                               parameters: plan,
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: NutritionPlan.self)
    }

    func updateNutritionPlan(plan: NutritionPlan) -> DataResponsePublisher<NutritionPlan> {
        return session.request(self.nutritionPlanURL + "\(plan.id)/",
                               method: .put,
                               parameters: plan,
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: NutritionPlan.self)
    }

    func deleteNutritionPlan(plan: NutritionPlan) -> DataResponsePublisher<Data> {
        return session.request(self.nutritionPlanURL + "\(plan.id)/",
                               method: .delete)
            .validate()
            .publishData()

    }
}
