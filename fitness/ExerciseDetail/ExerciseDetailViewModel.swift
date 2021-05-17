//
//  ExerciseDetailViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/16/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class ExerciseDetailViewModel: ObservableObject {

    // MARK: - Properties

    @Published var info: ExerciseInfo!

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NetExerciseInfo = Net()
    private let exercise: Exercise

    // MARK: - Initializers
    init(exercise: Exercise) {
        self.exercise = exercise
        getInfo()
    }

    // MARK: - Network

    func getInfo() {
        net.getExerciseInfo(id: exercise.id)
            .result()
            .map({ result in
                switch result {
                case let .success(info):
                    return info
                case let .failure(error):
                    debugPrint(error)
                    return nil
                }
            })
            .assign(to: \.info, on: self)
            .store(in: &cancellableSet)
    }
}
