//
//  NutritionPlanMealItemView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct NutritionPlanMealItemView: View {

    @Binding var mealItem: NutritionPlanInfo.Meal.Item

    // MARK: - UI

    var body: some View {
        if let ingredient = self.mealItem.ingredient {
            VStack(alignment: .leading) {
                Text(ingredient.name)
                    .font(.title2)
                HRowView(title: "Amount:", detail: self.mealItem.amount)
                Divider()
                HRowView(title: "Protein:", detail: ingredient.protein)
                HRowView(title: "Carbs:", detail: ingredient.carbohydrates)
                HRowView(title: "Fat:", detail: ingredient.fat)
            }
        }
    }
}
