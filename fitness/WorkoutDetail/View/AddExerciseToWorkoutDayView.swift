//
//  AddExerciseToWorkoutDayView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct AddExerciseToWorkoutDayView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: WorkoutDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var numberOfSets = 1
    @State private var setsRepeating = SetsRepeating.repeating
    @State private var numberOfReps = 1
    @State private var selectedIndex = 0

    // MARK: - UI

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    Text("This is will be a description.")
                        .font(.body)
                    ExerciseSettingRowView(
                        title: "Exercise: ",
                        description: "Find Exercise",
                        selection: self.viewModel.selectedExercise?.name ?? "No Exercise Selected",
                        destination: {
                            return SearchExerciseView()
                                .environmentObject(self.viewModel)
                        })
                    NumberOfSetsView(numberOfSets: $numberOfSets)
                    IsRepeatingView(selection: $setsRepeating)
                    ExerciseSettingRowView(title: "Reps",
                                           description: "Select you repititions",
                                           selection: "Some value") {
                        RepititionsView(numberOfSets: $numberOfSets,
                                        setsRepating: $setsRepeating,
                                        numberOfRepitions: $numberOfReps,
                                        selectedIndex: $selectedIndex)
                            .environmentObject(self.viewModel)
                    }
                }
                VStack(alignment: .center) {
                    Divider()
                    Button("Submit", action: addExerciseToWorkoutDay)
                        .buttonStyle(PrimaryButtonStyle())
                }
            }
            .navigationTitle("Add Workout Day")
            .onAppear(perform: getSettingRepitionsUnit)
        }
    }

    // MARK: - Actions
    func addExerciseToWorkoutDay() {

    }

    func getSettingRepitionsUnit() {
        self.viewModel.getSettingRepitionsUnit()
    }
}

struct AddExerciseToWorkoutDayView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseToWorkoutDayView()
    }
}
