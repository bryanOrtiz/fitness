//
//  CreateWorkoutSettingView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct CreateWorkoutSettingView: View {

    // MARK: - Properties
    @EnvironmentObject private var appDeps: AppDeps
    @ObservedObject var viewModel: CreateWorkoutSettingViewModel
    @Environment(\.presentationMode) var presentationMode

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
                        selection: self.$viewModel.selectedExerciseName,
                        destination: {
                            return SearchExerciseView()
                                .environmentObject(self.viewModel)
                        })
                    NumberOfSetsView()
                        .environmentObject(self.viewModel)
                    IsRepeatingView()
                        .environmentObject(self.viewModel)
                    RepititionsView()
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
        self.viewModel.onSubmit()
    }
}

// struct AddExerciseToWorkoutDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateWorkoutSettingView()
//    }
// }
