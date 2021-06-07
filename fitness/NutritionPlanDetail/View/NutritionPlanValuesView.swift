//
//  NutritionPlanValuesView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct NutritionPlanValuesView: View {

    // MARK: - Properties

    @Binding var values: NutritionPlanInfo.NutritionalValues

    // MARK: - UI

    var body: some View {
        Section(header: Text("Total")
                    .font(.title)) {
            HRowView(title: "Energy", detail: "\(values.total.energy)")
            HRowView(title: "Protein", detail: "\(values.total.protein)")
            HRowView(title: "Carbs", detail: "\(values.total.carbohydrates)")
            HRowView(title: "CarbSugars", detail: "\(values.total.carbohydratesSugar)")
            HRowView(title: "Fat", detail: "\(values.total.fat)")
            HRowView(title: "Saturated Fat", detail: "\(values.total.fatSaturated)")
            HRowView(title: "Fiber", detail: "\(values.total.fibres)")
            HRowView(title: "Sodium", detail: "\(values.total.sodium)")
            HRowView(title: "Energy Kj", detail: "\(values.total.energyKilojoule)")
        }
        Section(header: Text("Percent")
                    .font(.title)) {
            HRowView(title: "Protein", detail: "\(values.percent.protein)")
            HRowView(title: "Carbs", detail: "\(values.percent.carbohydrates)")
            HRowView(title: "Fat", detail: "\(values.percent.fat)")
        }
        Section(header: Text("PerKg")
                    .font(.title)) {
            HRowView(title: "Protein", detail: "\(values.perKG.protein)")
            HRowView(title: "Carbs", detail: "\(values.perKG.carbohydrates)")
            HRowView(title: "Fat", detail: "\(values.perKG.fat)")
        }
    }
}

// struct NutritionPlanValuesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NutritionPlanValuesView()
//    }
// }
