//
//  ExerciseCategoryDetailView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/15/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ExerciseCategoryDetailView: View {

    @ObservedObject var viewModel: ExerciseCategoryDetailViewModel

    init(category: ExerciseCategory) {
        viewModel = ExerciseCategoryDetailViewModel(category: category)
    }

    var body: some View {
        List {
            ForEach(viewModel.exercises, id: \.id) { exercise in
                NavigationLink(
                    destination: ExerciseDetailView(exercise: exercise),
                    label: {
                        VStack {
                            Text(exercise.name).font(.headline)
                            //                    Text(exercise.equipment.reduce("", { prev, equipment in
                            //                        return prev + ", \(equipment.name)"
                            //                    }) ).font(.subheadline)
                        }
                    })
            }
            .navigationBarTitle(Text(viewModel.category.name))
        }
    }
}

struct ExerciseCategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCategoryDetailView(category: ExerciseCategory(id: 0, name: "test"))
    }
}
