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

    @EnvironmentObject private var deps: AppDeps
    @StateObject var viewModel: NutritionPlanDetailViewModel
    @State private var isPresented = false

    // MARK: - UI

    var body: some View {
        Group {
            if let detailedPlan = self.viewModel.detailedPlan {
                List {
                    Section(header: VStack(alignment: .leading) {
                        RowView(title: "Description:", detail: detailedPlan.description)
                        HRowView(title: "Created at:", detail: detailedPlan.creationDate)
                    }) {
                        EmptyView()
                    }
                    NutritionPlanValuesView(values: self.$viewModel.values)
                    NutritionPlanMealsView(action: presentationAction)
                        .environmentObject(self.viewModel)
                }
            } else {
                FitnessEmptyView(title: "Could not retrieve details about your nutrition plan",
                          buttonText: "Reload",
                          buttonAction: { self.getDetail() })
            }
        }
        .sheet(isPresented: self.$isPresented) {
            CreateMealView(viewModel: CreateMealViewModel(net: self.deps.net,
                                                          planId: self.viewModel.detailedPlan!.id))
        }
        .onAppear(perform: {
            self.getDetail()
        })
    }

    // MARK: - Actions
    private func getDetail() {
        self.viewModel.getDetail()
    }

    // MARK: - Actions
    private func presentationAction() {
        self.isPresented.toggle()
    }
}
