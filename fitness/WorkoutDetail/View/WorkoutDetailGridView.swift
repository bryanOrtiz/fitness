//
//  WorkoutDetailGridView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct WorkoutDetailGridView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: WorkoutDetailViewModel
    @State private var isPresented = false

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                      alignment: HorizontalAlignment.center,
                      spacing: 8,
                      pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(viewModel.workout?.days ?? []) { day in
                    Section(header: Text(day.daysOfTheWeek.day),
                            footer: Button("Add Exercises", action: addExerciseToWorkoutDay)
                                .buttonStyle(SecondaryButtonStyle())) {
                        ForEach(day.sets) { set in
                            ForEach(set.exercises) { exerciseInfo in
                                CardView(title: exerciseInfo.exercise.name,
                                         imgURLString: exerciseInfo.images[0].image)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }.sheet(isPresented: $isPresented, content: {
            AddExerciseToWorkoutDayView()
        })
    }

    // MARK: - Actions
    func addExerciseToWorkoutDay() {
        isPresented.toggle()
    }
}

struct WorkoutDetailGridView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailGridView()
    }
}
