//
//  SearchIngredientView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI
import Combine

struct SearchIngredientView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: CreateMealItemViewModel
    @Environment(\.presentationMode) private var presentationMode

    // MARK: - UI

    var body: some View {
        VStack {
            VStack {
                Text("Find your ingredients and determine if they hit your macros")
                    .font(.subheadline)
                TextField("Search Ingredients", text: self.$viewModel.search)
            }
            .padding()
            List(self.viewModel.items,
                 selection: self.$viewModel.selectedItem) { item in
                Button(item.name) {
                    self.viewModel.selectedItem = item
                }
            }
            Divider()
            IngredientView()
                .environmentObject(self.viewModel)
            Button(action: self.action, label: {
                HStack {
                    Spacer()
                    Text("Select Ingredient")
                    Spacer()
                }
            })
            .environment(\.isEnabled, self.viewModel.selectedIngredient != nil)
            .padding()
            .buttonStyle(PrimaryButtonStyle())
        }
        .onReceive(self.viewModel.$didSelectItem, perform: { didSelectItem in
            guard didSelectItem else { return }
            self.presentationMode.wrappedValue.dismiss()
            self.viewModel.didSelectItem = false
        })
    }

    // MARK: - Actions
    func action() {
        self.viewModel.didSelectItem.toggle()
    }
}

struct MealItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchIngredientView(viewModel: CreateMealItemViewModel(net: Net(),
                                                                bus: PassthroughSubject<AppEvent, Never>(),
                                                                mealId: 0))
    }
}

struct IngredientView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: CreateMealItemViewModel

    // MARK: - UI

    var body: some View {
        if self.viewModel.items.isEmpty {
            EmptyView()
        } else if let selectedIngredient = self.viewModel.selectedIngredient {
            VStack(alignment: .leading) {
                Text(selectedIngredient.name)
                    .font(.title2)
                HRowView(title: "Protein:", detail: selectedIngredient.protein)
                HRowView(title: "Carbs:", detail: selectedIngredient.carbohydrates)
                HRowView(title: "Fat:", detail: selectedIngredient.fat)
            }
            .padding()
        } else {
            ProgressView()
        }
    }
}
