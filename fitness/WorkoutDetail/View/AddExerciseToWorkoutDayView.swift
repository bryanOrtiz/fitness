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

    // MARK: - UI

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    Text("This is will be a description.")
                        .font(.body)
                    NavigationLink(
                        destination: SearchExerciseView()
                            .environmentObject(self.viewModel)) {
                        VStack(alignment: .leading) {
                            HStack(alignment: .lastTextBaseline) {
                                Text("Exercise: ")
                                    .font(.headline)
                                Spacer()
                                Text(self.viewModel.selectedExercise?.name ?? "No Exercise Selected")
                                    .font(.headline)
                            }
                            Text("Find Exercise")
                                .font(.body)
                        }
                    }
                    NumberOfSetsView()
                    IsRepeatingView()
                }
                VStack(alignment: .center) {
                    Divider()
                    Button("Submit", action: addExerciseToWorkoutDay)
                        .buttonStyle(PrimaryButtonStyle())
                }
            }.navigationTitle("Add Workout Day")
        }
    }

    // MARK: - Actions
    func addExerciseToWorkoutDay() {

    }
}

struct AddExerciseToWorkoutDayView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseToWorkoutDayView()
    }
}
