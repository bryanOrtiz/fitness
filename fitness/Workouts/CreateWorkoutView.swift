//
//  CreateWorkoutView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/27/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct CreateWorkoutView: View {
    // MARK: - Properties

    @EnvironmentObject private var viewModel: WorkoutsViewModel
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
                TextField("Title of Workout", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Description")
                    .font(.headline)
                TextEditor(text: $description)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1))
            }
            Spacer()
            Button("Create", action: createAction)
                .buttonStyle(PrimaryButtonStyle())
        }.padding()
    }

    // MARK: - Actions
    func createAction() {
        viewModel.createWorkout(name: title, description: description) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CreateWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkoutView()
    }
}
