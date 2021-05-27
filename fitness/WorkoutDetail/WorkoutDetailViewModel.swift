//
//  WorkoutDetailViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class WorkoutDetailViewModel: ObservableObject {

    // MARK: - Properties

    @Published var workout: WorkoutInfo?
    @Published var net: NetWorkoutInfo!

    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Network

    func getWorkoutInfo(id: Int) {
        $net.compactMap({ $0 })
            .flatMap { net in
                return net.getWorkout(id: id)
                    .result()
            }
            .map({ result in
                switch result {
                case let .success(workout):
                    return workout
                case let .failure(error):
                    debugPrint("Error: ", error)
                    return nil
                }
            })
            .assign(to: \.workout, on: self)
            .store(in: &cancellableSet)
    }
}
