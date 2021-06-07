//
//  CreateMealViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class CreateMealViewModel: ObservableObject {

    // MARK: - Properties
    @Published var meal: NutritionPlanInfo.Meal
    @Published var date = Date()

    private var cancellableSet: Set<AnyCancellable> = []

    let net: CreateMealNet

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    // MARK: - Initializers

    init(net: CreateMealNet, planId: Int) {
        self.net = net
        self.meal = NutritionPlanInfo.Meal(id: 1,
                                            plan: planId,
                                            order: 1,
                                            time: nil,
                                            items: [NutritionPlanInfo.Meal.Item](),
                                            total: NutritionPlanInfo.NutritionalValues.Total(energy: 0,
                                                                                             protein: 0,
                                                                                             carbohydrates: 0,
                                                                                             carbohydratesSugar: 0,
                                                                                             fat: 0,
                                                                                             fatSaturated: 0,
                                                                                             fibres: 0,
                                                                                             sodium: 0,
                                                                                             energyKilojoule: 0))

        self.registerSubscribers()
    }

    // MARK: - NET

    func createMeal() {
        self.net.createMealTime(meal: self.meal)
            .result()
            .map { result in
                switch result {
                case let .success(meal):
                    return meal
                case let .failure(error):
                    debugPrint("error: \(error)")
                    return self.meal
                }
            }
            .assign(to: \.meal, on: self)
            .store(in: &cancellableSet)
    }

    // MARK: - Subscribers

    private func registerSubscribers() {
        self.registerDateChange()
    }

    private func registerDateChange() {
        self.$date
            .combineLatest(self.$meal)
            .map { tuple -> NutritionPlanInfo.Meal in
                let date = tuple.0
                let meal = tuple.1
                let test = self.dateFormatter.string(from: date)
                debugPrint("test: \(test)")
                return meal.time(time: test)
            }
            .assign(to: \.meal, on: self)
            .store(in: &cancellableSet)
    }
}
