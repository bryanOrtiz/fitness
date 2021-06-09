//
//  CreateMealItemView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/8/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI
import Combine

struct CreateMealItemView: View {

    // MARK: - Properties

    @StateObject var viewModel: CreateMealItemViewModel
    @Environment(\.presentationMode) private var presentationMode

    // MARK: - UI

    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(
                        destination: SearchIngredientView(viewModel: self.viewModel),
                        label: {
                            RowView(title: "Ingredient", detail: "\(self.viewModel.selectedItem?.id ?? 0)" )
                        })
                    VStack(alignment: .leading) {
                        Text("Amount")
                            .font(.headline)
                        TextField("1 g", text: self.$viewModel.amount)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                Divider()
                Button(action: {
                    self.viewModel.createMealItem()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Create")
                        Spacer()
                    }
                })
                .environment(\.isEnabled, self.viewModel.selectedIngredient != nil)
                .padding()
                .buttonStyle(PrimaryButtonStyle())
            }
            .onReceive(self.viewModel.$didComplete, perform: { didComplete in
                guard didComplete else { return }
                self.presentationMode.wrappedValue.dismiss()
            })
            .navigationTitle("Meal Item")
        }
    }
}

struct CreateMealItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMealItemView(viewModel: CreateMealItemViewModel(net: Net(),
                                                              bus: PassthroughSubject<AppEvent, Never>(),
                                                              mealId: 0))
    }
}
