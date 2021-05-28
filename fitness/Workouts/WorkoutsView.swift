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
    @State private var isPresentingSheet = false

    // MARK: - UI

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.workouts, id: \.id) { workout in
                    NavigationLink(destination: WorkoutDetailView(workoutId: workout.id)) {
                        RowView(title: workout.name, detail: workout.creationDate)
                    }
                }
            }
            .navigationTitle("Workouts")
            .navigationBarItems(trailing:
                                    Button(action: addAction, label: {
                                        Image(systemName: "plus")
                                    })
            )
            .onAppear(perform: {
                viewModel.net = deps.net
                viewModel.getWorkouts()
            })
            .sheet(isPresented: $isPresentingSheet) {
                CreateWorkoutView()
                    .environmentObject(viewModel)
            }
        }
    }

    // MARK: - Actions
    func addAction() {
        isPresentingSheet.toggle()
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
