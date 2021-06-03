//
//  ExerciseSettingDetailViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/2/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

final class ExerciseSettingDetailViewModel: ObservableObject {

    // MARK: - Properties

    let net: ExerciseSettingDetailNet
    let exerciseSetting: WorkoutInfoExercise

    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Publishers

    @Published var didDeleteSetting = false

    // MARK: - Initializers

    init(net: ExerciseSettingDetailNet, exerciseSetting: WorkoutInfoExercise) {
        self.net = net
        self.exerciseSetting = exerciseSetting
    }

    // MARK: - Net

    func editWorkoutSetting() {

    }

    func deleteWorkoutSetting() {
        let publishers = self.exerciseSetting.settings.map { setting in
            return self.net.delete(id: setting.id)
        }

        Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
            .map { _ in
                return true
            }
            .assertNoFailure() // TODO: fix
            .assign(to: \.didDeleteSetting, on: self)
            .store(in: &cancellableSet)
    }
}
