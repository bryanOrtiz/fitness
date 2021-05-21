//
//  NutrionPlansViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/21/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class NutritionPlansViewModel: ObservableObject {

    // MARK: - Properties
    @Published var plans = [NutritionPlan]()

    private var cancellableSet: Set<AnyCancellable> = []

    private let net: NetNutritionPlan = Net()

    // MARK: - NET

    func getPlans() {
        net.getNutritionPlan()
            .result()
            .map({ result in
                switch result {
                case let .success(page):
                    return page.results
                case let .failure(error):
                    debugPrint("Error: \(error)")
                    return []
                }
            })
            .assign(to: \.plans, on: self)
            .store(in: &cancellableSet)
    }
}
