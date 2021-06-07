//
//  NutritionPlanDetailView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/5/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct NutritionPlanDetailView: View {

    // MARK: - Properties

    @StateObject var viewModel: NutritionPlanDetailViewModel

    // MARK: - UI

    var body: some View {
        Text(self.$viewModel.detailedPlan.wrappedValue?.description ?? /*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: {
                self.viewModel.getDetail()
            })
    }
}
