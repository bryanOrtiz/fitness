//
//  NutritionPlanDetailNet.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/5/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

protocol NutritionPlanDetailNet {

    // MARK: - NutritionPlanInfo

    func getDetailedNutritionPlan(plan: NutritionPlan) -> DataResponsePublisher<NutritionPlanInfo>
    //    func updateNutritionPlan(plan: NutritionPlanInfo) -> DataResponsePublisher<NutritionPlanInfo>
    func deleteDetailedNutritionPlan(plan: NutritionPlanInfo) -> DataResponsePublisher<Data>

    // MARK: - Meal

    func createMealTime(meal: Meal) -> DataResponsePublisher<Meal>
}

extension Net: NutritionPlanDetailNet {

    // MARK: - NutritionPlanInfo

    var detailedNutritionPlanURL: String { "\(self.baseURL)nutritionplaninfo/" }

    func getDetailedNutritionPlan(plan: NutritionPlan) -> DataResponsePublisher<NutritionPlanInfo> {
        return session.request(self.detailedNutritionPlanURL + "\(plan.id)/")
            .validate()
            .publishDecodable(type: NutritionPlanInfo.self)
    }

    //
    //    func updateNutritionPlan(plan: NutritionPlanInfo) -> DataResponsePublisher<NutritionPlan> {
    //        return session.request(self.nutritionPlanURL + "\(plan.id)/",
    //                               method: .put,
    //                               parameters: plan,
    //                               encoder: JSONParameterEncoder.default)
    //            .validate()
    //            .publishDecodable(type: NutritionPlanInfo.self)
    //    }

    func deleteDetailedNutritionPlan(plan: NutritionPlanInfo) -> DataResponsePublisher<Data> {
        return session.request(self.detailedNutritionPlanURL + "\(plan.id)/",
                               method: .delete)
            .validate()
            .publishData()
    }

    // MARK: - Meals

    var mealTimeURL: String { "\(self.baseURL)meal/" }

    func createMealTime(meal: Meal) -> DataResponsePublisher<Meal> {
        return session.request(self.mealTimeURL,
                               method: .post,
                               parameters: meal,
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: Meal.self)
    }
}
