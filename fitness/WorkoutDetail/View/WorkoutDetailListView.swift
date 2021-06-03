//
//  WorkoutDetailListView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/2/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct WorkoutDetailListView: View {

    // MARK: - Properties
    @EnvironmentObject private var appDeps: AppDeps
    @EnvironmentObject private var viewModel: WorkoutDetailViewModel
    @State private var isPresented = false

    @State private var selectedExerciseDay: WorkoutDay!

    // MARK: - UI

    var body: some View {
        List {
            ForEach(viewModel.workout?.days ?? []) { day in
                Section(header: Text(day.daysOfTheWeek.day),
                        footer: Button("Add Exercises",
                                       action: { addExerciseToWorkoutDay(exerciseDay: day.day) })
                            .buttonStyle(SecondaryButtonStyle())) {
                    ForEach(day.sets) { set in
                        ForEach(set.exercises) { exerciseInfo in
                            NavigationLink(
                                destination:
                                    ExerciseSettingDetailView(
                                        viewModel:
                                            ExerciseSettingDetailViewModel(net: self.appDeps.net,
                                                                           exerciseSetting: exerciseInfo)
                                    ),
                                label: {
                                    HStack {
                                        Image(uiImage: #imageLiteral(resourceName: "exercise_placeholder"))
                                        Text(exerciseInfo.exercise.name)
                                    }
                                })
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isPresented, content: {
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

struct WorkoutDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailListView()
    }
}
