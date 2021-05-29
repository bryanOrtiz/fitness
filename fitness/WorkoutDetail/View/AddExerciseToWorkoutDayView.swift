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
    @State private var search = ""

    // MARK: - UI

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Add Workout Day")
                        .font(.largeTitle)
                    Spacer()
                    Text("This is will be a description.")
                        .font(.body)
                    TextField("", text: $search)
                        .onChange(of: search, perform: { term in
                            self.viewModel.searchExercises(search: term)
                        })
                    ForEach(self.viewModel.searchedExercises) { exercise in
                        Text("\(exercise.name)")
                    }
                }.padding()
            }
            VStack(alignment: .center) {
                Divider()
                Button("Submit", action: addExerciseToWorkoutDay)
                    .buttonStyle(PrimaryButtonStyle())
            }
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
