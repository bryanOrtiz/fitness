//
//  SearchIngredientView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct SearchIngredientView: View {

    @StateObject var viewModel: SearchIngredientViewModel

    var body: some View {
        List {
            Section(header: TextField("Type", text: self.$viewModel.search)) {
                ForEach(self.viewModel.items) { item in
                    Text(item.name)
                }
            }
        }
    }
}

struct MealItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchIngredientView(viewModel: SearchIngredientViewModel(net: Net()))
    }
}
