//
//  AddWorkoutDaysView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct AddWorkoutDaysView: View {

    // MARK: - Properties
    @EnvironmentObject private var viewModel: WorkoutDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var description = ""

    // MARK: - UI

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Add Workout Day")
                        .font(.largeTitle)
                    Spacer()
                    Text("Adding workout days will allow you to customize your workouts for the week. Each workout " +
                            "day will have a collection of exercises you do for that day. Make sure to select " +
                            "multiple days if you wish to repeat the same exercises for different days.")
                        .font(.body)
                    MultilineTextView(description: $description)
                    WorkoutDaysSelectionView()
                        .environmentObject(self.viewModel)
                }.padding()
            }
            VStack(alignment: .center) {
                Divider()
                Button("Submit", action: createWorkoutDays)
                    .buttonStyle(PrimaryButtonStyle())
            }
        }
        .onAppear(perform: {
            self.viewModel.getDaysOfTheWeek()
        })
    }

    // MARK: - Action
    func createWorkoutDays() {
        let indices = self.viewModel.daysOfTheWeek.enumerated().compactMap { index, binding in
            return binding.isSelected ? (index + 1) : nil
        }
        self.viewModel.createWorkoutDay(description: description, days: indices) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

private struct AddWorkoutDaysView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutDaysView()
    }
}
