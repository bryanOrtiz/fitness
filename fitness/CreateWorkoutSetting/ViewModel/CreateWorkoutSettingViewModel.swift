//
//  CreateWorkoutSettingViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/1/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine
import Alamofire

final class CreateWorkoutSettingViewModel: ObservableObject {

    // MARK: - Properties

    @Published var selectedExerciseName = "No Exercise Selected"

    @Published var setsRepeating = SetsRepeating.repeating
    @Published var set: ExerciseSet
    @Published var selectedExercise: SearchExercise.Data?
    @Published var exerciseSettings: [Setting]

    @Published var searchedExercises = [SearchExercise.Data]()
    @Published var settingRepUnits = [SettingsRepetitionUnit]()
    @Published var initialSettingRepUnits: SettingsRepetitionUnit?
    @Published var settingWeightUnits = [SettingsWeightUnit]()

    @Published var didMakeSetting = false

    private var cancellableSet: Set<AnyCancellable> = []

    let net: CreateWorkoutSettingNet
    let exerciseDay: WorkoutDay

    // MARK: - Initializers

    init(net: CreateWorkoutSettingNet, exerciseDay: WorkoutDay) {
        self.net = net
        self.exerciseDay = exerciseDay
        self.set = ExerciseSet(id: 0, exerciseDay: exerciseDay.id, sets: 1, order: 1)
        self.exerciseSettings = [
            Setting(id: 0,
                    set: 1,
                    exercise: 1,
                    repitionUnit: 1,
                    reps: 1,
                    weight: "1.0",
                    weightUnit: 1,
                    rir: nil,
                    order: 1,
                    comment: "")
        ]

        self.getInitialStates()
        self.registerChanges()
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
                self.exerciseSettings = self.exerciseSettings.map { setting -> Setting in
                    guard let unitId = value.first?.id else { return setting }
                    return setting.weightUnit(weightUnit: unitId)
                }
            })
            .store(in: &cancellableSet)
    }

    /// Main network call for creating a WorkoutSetting.
    /// This should iterate over the the `exerciseSettings` property and create a WorkoutSetting for each item
    ///  in the array.
    /// - Parameter repititionUnit: By default we are setting all repition units to be of type `Repitions`.
    /// We are not sure yet why we would need the other rep units.
    func onSubmit(repititionUnit: Int = 1) {
        self.net.createExerciseSet(set: self.set)
            .flatMap { set -> AnyPublisher<[Setting], AFError> in
                let publishers = self.exerciseSettings.map { setting in
                    return self.net.createExerciseSetting(setting: setting
                                                            .set(set: set.id)
                                                            .exercise(exercise: self.selectedExercise!.id))
                }
                return Publishers.MergeMany(publishers)
                    .collect()
                    .eraseToAnyPublisher()
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

    // MARK: - Changes
    private func registerChanges() {
        self.setsChange()
        self.selectedExerciseNameChange()
    }

    private func setsChange() {
        self.$set
            .combineLatest(self.$setsRepeating)
            .map { output -> [Setting] in
                let exerciseSet: ExerciseSet = output.0
                let repeating: SetsRepeating = output.1
                if repeating == .repeating, self.exerciseSettings.count > 1 {
                    self.exerciseSettings.removeSubrange(1...self.exerciseSettings.count-1)
                } else if repeating == .custom {
                    let difference = abs(exerciseSet.sets - self.exerciseSettings.count)
                    if exerciseSet.sets < self.exerciseSettings.count {
                        self.exerciseSettings.removeSubrange(exerciseSet.sets...self.exerciseSettings.count-1)
                    } else if difference > 0, let last = self.exerciseSettings.last {
                        let newArray = Array(1...difference).map { _ in
                            return Setting(id: Int.random(in: 1...10000),
                                           set: last.set,
                                           exercise: last.exercise,
                                           repitionUnit: last.repitionUnit,
                                           reps: last.reps,
                                           weight: last.weight,
                                           weightUnit: last.weightUnit,
                                           rir: last.rir,
                                           order: last.order,
                                           comment: last.comment)
                        }
                        self.exerciseSettings.append(contentsOf: newArray)
                    }
                }
                return self.exerciseSettings
            }
            .receive(on: RunLoop.main)
            .assign(to: \.exerciseSettings, on: self)
            .store(in: &cancellableSet)
    }

    func updateSettings(with newSetting: Setting) {
        guard let index = self.exerciseSettings.firstIndex(where: { $0.id == newSetting.id }) else { return }
        self.exerciseSettings[index] = newSetting
    }

    func getWeightUnitName(setting: Setting) -> String {
        return self.settingWeightUnits.first(where: { $0.id == setting.weightUnit })?.name ?? ""
    }

    func setWeightUnitName(name: String, setting: Setting) {
        guard let newUnit = self.settingWeightUnits.first(where: { $0.name == name }),
              let index = self.exerciseSettings.firstIndex(where: { $0 == setting }) else { return }

        let new = self.exerciseSettings[index].weightUnit(weightUnit: newUnit.id)
        self.exerciseSettings[index] = new
    }

    private func selectedExerciseNameChange() {
        self.$selectedExercise
            .map { selectedExercise in
                return selectedExercise?.name ?? "No Exercise Selected"
            }
            .assign(to: \.selectedExerciseName, on: self)
            .store(in: &cancellableSet)
    }
}
