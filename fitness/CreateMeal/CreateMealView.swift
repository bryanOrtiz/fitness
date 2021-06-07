//
//  CreateMealView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct CreateMealView: View {

    // MARK: - Properties

    @StateObject var viewModel: CreateMealViewModel

    // MARK: - UI

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Add a new meal")
                    Text("Set a time you would think you will be eating your meal.")
                    DatePicker("Time",
                               selection: self.$viewModel.date,
                               displayedComponents: [.hourAndMinute])
                }
            }
            Divider()
            Button("Submit", action: action)
                .buttonStyle(PrimaryButtonStyle())
                .padding()
        }
        .padding()
    }

    // MARK: - Actions
    private func action() {
        self.viewModel.createMeal()
    }
}

struct CreateMealView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMealView(viewModel: CreateMealViewModel(net: Net(), planId: 1))
    }
}
