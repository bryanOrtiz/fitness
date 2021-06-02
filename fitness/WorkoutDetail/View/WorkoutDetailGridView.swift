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
    @EnvironmentObject private var appDeps: AppDeps
    @EnvironmentObject private var viewModel: WorkoutDetailViewModel
    @State private var isPresented = false

    @State private var selectedExerciseDay: WorkoutDay!

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                      alignment: HorizontalAlignment.center,
                      spacing: 8,
                      pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(viewModel.workout?.days ?? []) { day in
                    Section(header: Text(day.daysOfTheWeek.day),
                            footer: Button("Add Exercises",
                                           action: { addExerciseToWorkoutDay(exerciseDay: day.day) })
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
            CreateWorkoutSettingView(
                viewModel: CreateWorkoutSettingViewModel(net: self.appDeps.net,
                                                         exerciseDay: self.viewModel.selectedExerciseDay))
        })
    }

    // MARK: - Actions
    func addExerciseToWorkoutDay(exerciseDay: WorkoutDay) {
        self.viewModel.selectedExerciseDay = exerciseDay
        isPresented.toggle()
    }
}

struct WorkoutDetailGridView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailGridView()
    }
}
