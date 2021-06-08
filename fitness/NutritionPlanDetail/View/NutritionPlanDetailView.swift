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
    @State private var addItemIsPresent = false
    @State private var mealId: Int = 0

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
                    NutritionPlanMealsView(action: self.presentationAction,
                                           addItemAction: self.addItemAction)
                        .environmentObject(self.viewModel)
                }
            } else {
                FitnessEmptyView(title: "Could not retrieve details about your nutrition plan",
                          buttonText: "Reload",
                          buttonAction: { self.getDetail() })
            }
        }
//        .sheet(isPresented: self.$isPresented) {
//            CreateMealView(viewModel: CreateMealViewModel(net: self.deps.net,
//                                                          planId: self.viewModel.detailedPlan!.id))
//        }
        .sheet(isPresented: self.$addItemIsPresent, content: {
            CreateMealItemView(createMealItemViewModel: CreateMealItemViewModel(net: self.deps.net,
                                                                                mealId: self.mealId))
        })
        .onAppear(perform: {
            self.getDetail()
        })
    }

    // MARK: - Actions
    private func getDetail() {
        self.viewModel.getDetail()
    }

    private func presentationAction() {
        self.isPresented.toggle()
    }

    private func addItemAction(mealId: Int) {
        self.mealId = mealId
        self.addItemIsPresent.toggle()
    }
}
