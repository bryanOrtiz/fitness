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
    @EnvironmentObject private var deps: AppDeps
    @StateObject var viewModel: NutritionPlansViewModel

    // MARK: - UI

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.plans) { plan in
                    NavigationLink(
                        destination: NutritionPlanDetailView(viewModel: NutritionPlanDetailViewModel(net: self.deps.net,
                                                                                                     plan: plan))
                            .environmentObject(self.deps),
                        label: {
                            RowView(title: plan.creationDate, detail: plan.description)
                        })
                }
                .onDelete { set in
                    print("delete at set: \(set)")
                }
            }
            .navigationBarItems(trailing: EditButton())
//            .toolbar(content: {
//                EditButton()
//            })
            .navigationBarTitle(Text("Nutrition Plans"))
            .onAppear(perform: {
                viewModel.getPlans()
            })
        }
    }
}

struct NutritionPlansListView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionPlansListView(viewModel: NutritionPlansViewModel(net: Net()))
    }
}
