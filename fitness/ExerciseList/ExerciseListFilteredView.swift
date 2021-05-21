//
//  ExerciseListFilteredView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/20/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ExerciseListFilteredView: View {

    // MARK: - Properties
    let filter: ExerciseFilter
    @StateObject private var viewModel = ExerciseCategoriesViewModel()

    // MARK: - UI

    var body: some View {
        switch filter {
        case .category:
            ForEach(viewModel.categories, id: \.id) { categories in
                NavigationLink(
                    destination: ExerciseCategoryDetailView(category: categories),
                    label: {
                        Text(categories.name)
                    })
            }
        case .mucsle:
            ForEach(viewModel.muscles, id: \.id) { categories in
                NavigationLink(
                    destination: EmptyView(),
                    label: {
                        Text(categories.name)
                    })
            }
        case .equipment:
            ForEach(viewModel.equipment, id: \.id) { categories in
                NavigationLink(
                    destination: EmptyView(),
                    label: {
                        Text(categories.name)
                    })
            }
        }
    }
}
