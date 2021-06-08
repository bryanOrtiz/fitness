//
//  SearchExerciseView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/30/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct SearchExerciseView: View {

    // MARK: - UI
    @EnvironmentObject private var viewModel: CreateWorkoutSettingViewModel
    @State private var search = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Find Exercise", text: $search)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: search, perform: { term in
                    self.viewModel.searchExercises(search: term)
                })
                .padding()
            List {
                ForEach(self.viewModel.searchedExercises) { exercise in
                    Button("\(exercise.name)", action: { self.didSelectExercise(exercise: exercise) })
                }
            }
        }.onAppear(perform: searchWithEmptyTerms)
    }

    // MARK: - Action
    func didSelectExercise(exercise: SearchExercise) {
        self.viewModel.selectedExercise = exercise
        self.viewModel.searchedExercises = []
        self.presentationMode.wrappedValue.dismiss()
    }

    func searchWithEmptyTerms() {
        self.viewModel.searchExercises(search: "")
    }
}
