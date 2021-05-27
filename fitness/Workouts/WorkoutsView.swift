//
//  WorkoutsView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/17/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct WorkoutsView: View {

    // MARK: - Properties

    @EnvironmentObject private var deps: AppDeps
    @StateObject var viewModel = WorkoutsViewModel()

    // MARK: - UI

    var body: some View {
        List {
            ForEach(viewModel.workouts, id: \.id) { workout in
                NavigationLink(destination: WorkoutDetailView(workoutId: workout.id)) {
                    RowView(title: workout.name, detail: workout.creationDate)
                }
            }
        }.navigationTitle("Workouts")
        .onAppear(perform: {
            viewModel.net = deps.net
        })
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
