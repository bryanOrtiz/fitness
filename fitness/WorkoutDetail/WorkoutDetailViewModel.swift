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
    @Published var net: (NetWorkoutInfo & NetWorkout)!

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

    func editWorkout(name: String,
                     description: String,
                     completion: @escaping () -> Void) {
        net.editWorkout(id: workout!.workout.id, name: name, description: description)
            .result()
            .map({ result -> Void in
                switch result {
                case let .success(workout):
                    return self.getWorkoutInfo(id: workout.id)
                case let .failure(error):
                    debugPrint("error: \(error)")
                    return ()
                }
            })
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in completion() })
            .store(in: &cancellableSet)
    }
}
