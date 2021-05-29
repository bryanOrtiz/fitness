//
//  EmptyWorkoutDaysView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct EmptyWorkoutDaysView: View {

    // MARK: - Properties
    @EnvironmentObject private var viewModel: WorkoutDetailViewModel
    @State private var isPresented = false

    // MARK: - UI

    var body: some View {
        VStack {
            Spacer()
            Text("It seems you do not have any workout days associated with this week's workout.")
                .font(.headline)
            Spacer()
            Button("Add days to workout week", action: addDays)
                .buttonStyle(PrimaryButtonStyle())
        }.sheet(isPresented: $isPresented, content: {
            AddWorkoutDaysView()
                .environmentObject(self.viewModel)
        }).padding()
    }

    // MARK: - Actions
    func addDays() {
        isPresented.toggle()
    }
}
