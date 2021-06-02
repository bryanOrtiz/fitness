//
//  CreateWorkoutSettingView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

/**
 1. Create Workout day/ exercise day
 2. Find Exercise
 3. Set Exercise, Set reps, Set Weight, Set Weight unit, set rep unit in UI
 4. Hit Submit
 5. Create Set with workoutDay and numOfSets
 6. Create Settings model
 5. Make network request for creating Workout Settings
 6. Success Dismiss
 7. Error ??
 */

import SwiftUI

struct CreateWorkoutSettingView: View {

    // MARK: - Properties
    @EnvironmentObject private var appDeps: AppDeps
    @ObservedObject var viewModel: CreateWorkoutSettingViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var numberOfSets = 1
    @State private var setsRepeating = SetsRepeating.repeating
    @State private var numberOfReps = 1
    @State private var weight: Double = 1
    @State private var selectedIndex = 0

    init(viewModel: CreateWorkoutSettingViewModel) {
        self.viewModel = viewModel
    }

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
                    RepititionsView(numberOfSets: $numberOfSets,
                                    setsRepating: $setsRepeating,
                                    numberOfRepitions: $numberOfReps,
                                    weight: self.$weight,
                                    selectedIndex: $selectedIndex)
                        .environmentObject(self.viewModel)
                }
                VStack(alignment: .center) {
                    Divider()
                    Button("Submit", action: addExerciseToWorkoutDay)
                        .buttonStyle(PrimaryButtonStyle())
                }
            }
            .navigationTitle("Add Workout Day")
            .onReceive(self.viewModel.$didMakeSetting, perform: { didFinish in
                guard didFinish else { return }
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }

    // MARK: - Actions
    func addExerciseToWorkoutDay() {
        self.viewModel.onSubmit(numberOfSets: numberOfSets,
                                reps: numberOfReps,
                                weight: weight)
    }
}

// struct AddExerciseToWorkoutDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateWorkoutSettingView()
//    }
// }
