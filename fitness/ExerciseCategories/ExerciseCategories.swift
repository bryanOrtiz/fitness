//
//  ExerciseCategories.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/15/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ExerciseCategories: View {

    @ObservedObject var exerciseViewModel = ExerciseCategoriesViewModel()

    var body: some View {
        List {
            ForEach(exerciseViewModel.categories, id: \.id) { categories in
                NavigationLink(
                    destination: ExerciseCategoryDetailView(category: categories),
                    label: {
                        Text(categories.name)
                    })
            }
        }.navigationBarTitle(Text("Categories"))
    }
}

struct Exercises_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCategories()
    }
}
