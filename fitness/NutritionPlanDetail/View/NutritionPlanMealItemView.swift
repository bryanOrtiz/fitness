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
        VStack(alignment: .leading) {
            Text(self.mealItem.ingredient.name)
                .font(.title2)
            HRowView(title: "Amount:", detail: self.mealItem.amount)
            Divider()
            HRowView(title: "Protein:", detail: self.mealItem.ingredient.protein)
            HRowView(title: "Carbs:", detail: self.mealItem.ingredient.carbohydrates)
            HRowView(title: "Fat:", detail: self.mealItem.ingredient.fat)
        }
    }
}
