//
//  NutritionPlansListView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/21/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct NutritionPlansListView: View {

    // MARK: - Properties

    @StateObject private var viewModel = NutritionPlansViewModel()

    // MARK: - UI

    var body: some View {
        List {
            ForEach(viewModel.plans) {
                RowView(title: $0.creationDate, detail: $0.description)
            }
        }
        .navigationBarTitle(Text("Nutrition Plans"))
        .onAppear(perform: {
            viewModel.getPlans()
        })
    }
}

struct NutritionPlansListView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionPlansListView()
    }
}
