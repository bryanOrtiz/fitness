//
//  CreateMealNet.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

protocol CreateMealNet {

    // MARK: - Meal

    func createMealTime(meal: NutritionPlanInfo.Meal) -> DataResponsePublisher<NutritionPlanInfo.Meal>
}

extension Net: CreateMealNet {

    var mealTimeURL: String { "\(self.baseURL)meal/" }

    func createMealTime(meal: NutritionPlanInfo.Meal) -> DataResponsePublisher<NutritionPlanInfo.Meal> {
        return session.request(self.mealTimeURL,
                               method: .post,
                               parameters: meal,
                               encoder: JSONParameterEncoder.default)
            .responseJSON(completionHandler: { debugPrint("response: \($0)") })
            .validate()
            .publishDecodable(type: NutritionPlanInfo.Meal.self)
    }
}
