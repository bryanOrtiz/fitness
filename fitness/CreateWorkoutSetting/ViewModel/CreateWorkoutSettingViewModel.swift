//
//  CreateWorkoutSettingViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/1/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

final class CreateWorkoutSettingViewModel: ObservableObject {

    // MARK: - Properties

    @Published var searchedExercises = [SearchExercise.Data]()
    @Published var selectedExercise: SearchExercise.Data?
    @Published var settingRepUnits = [SettingsRepetitionUnit]()
    @Published var initialSettingRepUnits: SettingsRepetitionUnit?
    @Published var settingWeightUnits = [SettingsWeightUnit]()
    @Published var selectedSettingWeightUnits: SettingsWeightUnit!

    @Published var didMakeSetting = false

    private var cancellableSet: Set<AnyCancellable> = []

    let net: CreateWorkoutSettingNet
    let exerciseDay: WorkoutDay

    // MARK: - Initializers

    init(net: CreateWorkoutSettingNet, exerciseDay: WorkoutDay) {
        self.net = net
        self.exerciseDay = exerciseDay

        self.getInitialStates()
    }

    // MARK: - Net
    private func getInitialStates() {
        self.getSettingWeightUnit()
        self.getSettingRepitionsUnit()
    }

    func searchExercises(search: String) {
        net.getExercise(by: search)
            .receive(on: RunLoop.main)
            .assertNoFailure()
            .assign(to: \.searchedExercises, on: self)
            .store(in: &cancellableSet)
    }

    private func getSettingRepitionsUnit() {
        net.getSettingRepetitioUnit()
            .receive(on: RunLoop.main)
            .assertNoFailure()
            .sink(receiveValue: { value in
                self.settingRepUnits = value
                self.initialSettingRepUnits = value.first
            })
            .store(in: &cancellableSet)
    }

    private func getSettingWeightUnit() {
        net.getSettingWeightUnit()
            .receive(on: RunLoop.main)
            .assertNoFailure()
            .sink(receiveValue: { value in
                self.settingWeightUnits = value
                guard self.selectedSettingWeightUnits == nil else { return }
                self.selectedSettingWeightUnits = value.first
            })
            .store(in: &cancellableSet)
    }

    func onSubmit(numberOfSets: Int,
                  repititionUnit: Int = 1,
                  reps: Int,
                  weight: Double) {
        self.net.createExerciseSet(set: ExerciseSet(id: 0,
                                                    exerciseDay: self.exerciseDay.id,
                                                    sets: numberOfSets,
                                                    order: 0))
            .flatMap { set in
                return self.net.createExerciseSetting(setting: Setting(id: 0,
                                                                       set: set.id,
                                                                       exercise: self.selectedExercise!.id,
                                                                       repitionUnit: repititionUnit,
                                                                       reps: reps,
                                                                       weight: "\(weight)",
                                                                       weightUnit: self.selectedSettingWeightUnits.id,
                                                                       rir: nil,
                                                                       order: 0,
                                                                       comment: ""))
            }
            .sink { completion in
                switch completion {
                case let .failure(error):
                    debugPrint("Error: \(error)")
                    return
                case .finished:
                    self.didMakeSetting = true
                    return
                }
            } receiveValue: { setting in
                debugPrint("setting: \(setting)")
                return
            }
            .store(in: &cancellableSet)
    }
}
