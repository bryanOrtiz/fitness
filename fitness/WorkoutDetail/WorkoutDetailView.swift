//
//  WorkoutDetailView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct WorkoutDetailView: View {

    // MARK: - Properties
    @ObservedObject var viewModel: WorkoutDetailViewModel

    // MARK: - Initializers
    init(workoutId: Int) {
        self.viewModel = WorkoutDetailViewModel(workoutId: workoutId)
    }

    // MARK: - UI

    var body: some View {
        List {
            ForEach(viewModel.workout?.days ?? [], id: \.id) { day in
                Section(header: Text(day.daysOfTheWeek.day)) {
                    ForEach(day.sets) { set in
                        ForEach(set.exercises) { exerciseInfo in
                            CardView(title: exerciseInfo.exercise.name,
                                     imgURLString: exerciseInfo.images[0].image)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(viewModel.workout?.workout.name ?? "No Title")
        .navigationBarItems(trailing:
                                Button("Edit", action: {
                                    debugPrint("editing")
                                })
        )
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workoutId: 1)
    }
}
