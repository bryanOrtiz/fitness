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

    // MARK: - UI

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                      alignment: HorizontalAlignment.center,
                      spacing: 8,
                      pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(viewModel.workout?.days ?? [], id: \.id) { day in
                    Section(header: Text(day.daysOfTheWeek.day)) {
                        ForEach(day.sets) { set in
                            ForEach(set.exercises) { exerciseInfo in
                                CardView(title: exerciseInfo.exercise.name,
                                         imgURLString: exerciseInfo.images[0].image)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(viewModel.workout?.workout.name ?? "No Title")
        .navigationBarItems(trailing:
                                Button("Edit", action: {
                                    debugPrint("editing")
                                })
        )
        .onAppear(perform: {
            viewModel.net = deps.net
            viewModel.getWorkoutInfo(id: workoutId)
        })
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workoutId: 1)
    }
}
