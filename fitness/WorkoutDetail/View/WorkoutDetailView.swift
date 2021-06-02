//
//  WorkoutDetailView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct WorkoutDetailView: View {

    // MARK: - Properties
    @EnvironmentObject private var deps: AppDeps
    @StateObject var viewModel = WorkoutDetailViewModel()
    let workoutId: Int
    @State private var isPresentingSheet = false

    // MARK: - UI

    var body: some View {
        Group {
            if (self.viewModel.workout?.days ?? []).isEmpty {
                EmptyWorkoutDaysView()
                    .environmentObject(self.viewModel)
            } else {
//                WorkoutDetailGridView()
                WorkoutDetailListView()
                    .environmentObject(self.viewModel)
                    .environmentObject(self.deps)
            }
        }
        .navigationBarTitle(viewModel.workout?.workout.name ?? "No Title")
        .navigationBarItems(trailing:
                                Button("Edit", action: {
                                    isPresentingSheet.toggle()
                                })
        )
        .onAppear(perform: {
            viewModel.net = deps.net
            viewModel.getWorkoutInfo(id: workoutId)
        })
        .sheet(isPresented: $isPresentingSheet) {
            EditWorkoutDetailView()
                .environmentObject(viewModel)
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workoutId: 1)
    }
}
