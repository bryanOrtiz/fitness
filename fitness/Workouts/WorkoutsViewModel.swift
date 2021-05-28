//
//  WorkoutsViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/17/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class WorkoutsViewModel: ObservableObject {

    // MARK: - Properties
    @Published var workouts = [Workout]()
    @Published var net: NetWorkout!

    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Network

    func getWorkouts() {
        net.getWorkout()
            .result()
            .map({ result in
                switch result {
                case let .success(page):
                    return page.results
                case let .failure(error):
                    debugPrint("error:", error)
                    return []
                }
            })
            .assign(to: \.workouts, on: self)
            .store(in: &cancellableSet)
    }

    func createWorkout(name: String,
                       description: String,
                       completion: @escaping () -> Void) {
        net.createWorkout(name: name, description: description)
            .result()
            .map({ result -> Void in
                switch result {
                case .success(_):
                    return self.getWorkouts()
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
