//
//  SearchIngredientView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct SearchIngredientView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: CreateMealItemViewModel
    @Environment(\.presentationMode) var presentationMode

    // MARK: - UI

    var body: some View {
        VStack {
            TextField("Type", text: self.$viewModel.search)
            List(self.viewModel.items,
                 selection: self.$viewModel.selectedItem) { item in
                Button(item.name) {
                    self.viewModel.selectedItem = item
                }
            }
        }
        .onReceive(self.viewModel.$didSelectItem, perform: { didSelectItem in
            guard didSelectItem else { return }
            self.presentationMode.wrappedValue.dismiss()
            self.viewModel.didSelectItem = false
        })
    }
}

struct MealItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchIngredientView(viewModel: CreateMealItemViewModel(net: Net(), mealId: 0))
    }
}
