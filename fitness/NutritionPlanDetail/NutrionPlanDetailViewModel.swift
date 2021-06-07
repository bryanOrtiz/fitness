//
//  NutrionPlanDetailViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/5/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class NutritionPlanDetailViewModel: ObservableObject {

    // MARK: - Properties
    @Published var detailedPlan: NutritionPlanInfo?
    @Published var values: NutritionPlanInfo.NutritionalValues!
    @Published var meals = [NutritionPlanInfo.Meal]()

    @Published var plan: NutritionPlan

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NutritionPlanDetailNet

    // MARK: - Initilaizers

    init(net: NutritionPlanDetailNet, plan: NutritionPlan) {
        self.net = net
        self.plan = plan

        self.registerUpdates()
    }

    // MARK: - NET

    func getDetail() {
        self.net.getDetailedNutritionPlan(plan: self.plan)
            .result()
            .map({ result in
                switch result {
                case let .success(plan):
                    return plan
                case let .failure(error):
                    debugPrint("error: \(error)")
                    return nil
                }
            })
            .assign(to: \.detailedPlan, on: self)
            .store(in: &cancellableSet)
    }

    func scheduleNewMeal(date: String) {

    }

    // MARK: - Publishers
    private func registerUpdates() {
        self.registerValueUpdates()
        self.registerMealsUpdates()
    }

    private func registerValueUpdates() {
        self.$detailedPlan
            .compactMap({ $0 })
            .map { plan in
                return plan.nutritionalValues
            }
            .assign(to: \.values, on: self)
            .store(in: &cancellableSet)
    }

    private func registerMealsUpdates() {
        self.$detailedPlan
            .compactMap({ $0 })
            .map { plan in
                return plan.meals
            }
            .assign(to: \.meals, on: self)
            .store(in: &cancellableSet)
    }
}
