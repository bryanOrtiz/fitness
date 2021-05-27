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

    // MARK: - Initializers
    init() {
        getWorkouts()
    }

    // MARK: - Network

    func getWorkouts() {
        $net.compactMap({ $0 })
            .flatMap { net in
                return net.getWorkout()
                    .result()
            }
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
}
