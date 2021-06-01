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

    @Published private(set) var workout: WorkoutInfo?
    @Published var daysOfTheWeek = [BindingDayOfTheWeek]()
    @Published var searchedExercises = [SearchExercise.Data]()
    @Published var selectedExercise: SearchExercise.Data?
    @Published var settingRepUnits = [SettingsRepetitionUnit]()
    @Published var initialSettingRepUnits: SettingsRepetitionUnit?

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

    func deleteWorkout(completion: @escaping () -> Void) {
        net.deleteWorkout(id: workout!.workout.id)
            .result()
            .map({ result -> Void in
                switch result {
                case .success(_):
                    return ()
                case let .failure(error):
                    debugPrint("error: \(error)")
                    return ()
                }
            })
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in completion() })
            .store(in: &cancellableSet)
    }

    func getDaysOfTheWeek() {
        net.getDaysOfTheWeek()
            .result()
            .map { result in
                switch result {
                case let .success(page):
                    return page.results.map { day in
                        return BindingDayOfTheWeek(day: day)
                    }
                case let.failure(error):
                    debugPrint("error: \(error)")
                    return []
                }
            }
            .assign(to: \.daysOfTheWeek, on: self)
            .store(in: &cancellableSet)
    }

    func createWorkoutDay(description: String,
                          days: [Int],
                          completion: @escaping () -> Void) {
        net.createWorkoutDay(workoutId: self.workout!.workout.id, description: description, days: days)
            .result()
            .map({ result -> Void in
                switch result {
                case let .success(day):
                    return self.getWorkoutInfo(id: day.training)
                case let .failure(error):
                    debugPrint(error)
                    return ()
                }
            })
            .receive(on: RunLoop.main)
            .sink { _ in completion() }
            .store(in: &cancellableSet)
    }

    func searchExercises(search: String) {
        net.getExercise(by: search)
            .receive(on: RunLoop.main)
            .assertNoFailure()
            .assign(to: \.searchedExercises, on: self)
            .store(in: &cancellableSet)
    }

    func getSettingRepitionsUnit() {
        net.getSettingRepetitioUnit()
            .receive(on: RunLoop.main)
            .assertNoFailure()
            .sink(receiveValue: { value in
                self.settingRepUnits = value
                self.initialSettingRepUnits = value.first
            })
            .store(in: &cancellableSet)
    }
}
