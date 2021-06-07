//
//  NutritionPlanMealsView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct NutritionPlanMealsView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: NutritionPlanDetailViewModel
    let action: () -> Void

    // MARK: - UI

    var body: some View {
        ForEach(self.viewModel.meals) { meal in
            Section(header: HRowView(title: "Time:", detail: meal.time ?? "No Time Provided")) {
                ForEach(meal.items) { item in
                    NutritionPlanMealItemView(mealItem: Binding<NutritionPlanInfo.Meal.Item>(get: { item },
                                                                                             set: { _ in }))
                }
            }
        }
        Button(action: self.action) {
            Text("Schedule a new meal")
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}