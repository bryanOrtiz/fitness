//
//  CreateMealItemView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/8/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct CreateMealItemView: View {

    // MARK: - Properties

    @StateObject var createMealItemViewModel: CreateMealItemViewModel

    // MARK: - UI

    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: SearchIngredientView(viewModel: self.createMealItemViewModel),
                    label: {
                        RowView(title: "Ingredient", detail: "\(self.createMealItemViewModel.selectedItem?.id ?? 0)" )
                    })
                RowView(title: "Amount", detail: "No ingredient selected")
            }
        }
    }
}

struct CreateMealItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMealItemView(createMealItemViewModel: CreateMealItemViewModel(net: Net(), mealId: 0))
    }
}
