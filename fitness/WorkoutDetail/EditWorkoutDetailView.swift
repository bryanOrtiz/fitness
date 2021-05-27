//
//  EditWorkoutDetailView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/27/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct EditWorkoutDetailView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: WorkoutDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""

    // MARK: - UI

    var body: some View {
        VStack {
            Text("Edit Workout")
                .font(.title)
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.headline)
                TextField("", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Description")
                    .font(.headline)
                TextEditor(text: $description)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1))
            }
            Spacer()
            Button("Update", action: updateAction)
                .buttonStyle(PrimaryButtonStyle())
        }.padding()
        .onAppear(perform: {
            title = viewModel.workout?.workout.name ?? ""
            description = viewModel.workout?.workout.description ?? ""
        })
    }

    // MARK: - Actions
    func updateAction() {
        viewModel.editWorkout(name: title, description: description) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
