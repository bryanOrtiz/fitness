//
//  NetWorkout.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/17/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import Combine

protocol NetWorkout {

    // MARK: - Workout

    func getWorkout() -> DataResponsePublisher<Page<Workout>>

    func createWorkout(name: String,
                       description: String) -> DataResponsePublisher<Workout>

    func editWorkout(id: Int,
                     name: String,
                     description: String) -> DataResponsePublisher<Workout>

    func deleteWorkout(id: Int) -> DataResponsePublisher<Data>

    // MARK: - Days of the week

    func getDaysOfTheWeek() -> DataResponsePublisher<Page<DayOfTheWeek>>

    // MARK: - Workout Day

    func getWorkoutDays() -> DataResponsePublisher<Page<WorkoutDay>>

    /// This should create a WorkoutDay where one can add Exercises to it.
    /// - Parameters:
    ///   - workoutId: The id of the Workout struct
    ///   - description: A brief description so that the user can know more about this day and its purpose
    ///   - day: REST documentation shows that we need to pass in the index of the day of the week
    ///    (i.e. Monday = 1, Tuesday = 2, ..., Sunday = 7)
    func createWorkoutDay(workoutId: Int, description: String, days: [Int]) -> DataResponsePublisher<WorkoutDay>

    // MARK: - Exercise

    func getExercise(by term: String) -> AnyPublisher<[SearchExercise.Data], AFError>
}

extension Net: NetWorkout {

    func getWorkout() -> DataResponsePublisher<Page<Workout>> {
        return session.request(self.baseURL + "workout/")
            .validate()
            .publishDecodable(type: Page<Workout>.self)
    }

    func createWorkout(name: String,
                       description: String) -> DataResponsePublisher<Workout> {
        return session.request(self.baseURL + "workout/",
                               method: .post,
                               parameters: ["name": name, "description": description],
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: Workout.self)
    }

    func editWorkout(id: Int,
                     name: String,
                     description: String) -> DataResponsePublisher<Workout> {
        return session.request(self.baseURL + "workout/\(id)/",
                               method: .patch,
                               parameters: ["name": name, "description": description],
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: Workout.self)
    }

    func deleteWorkout(id: Int) -> DataResponsePublisher<Data> {
        return session.request(self.baseURL + "workout/\(id)/",
                               method: .delete)
            .validate()
            .publishData()
    }

    // MARK: - Days of the week

    var daysOfTheWeekURL: String { "\(self.baseURL)/daysofweek/" }

    func getDaysOfTheWeek() -> DataResponsePublisher<Page<DayOfTheWeek>> {
        return session.request(self.daysOfTheWeekURL)
            .validate()
            .publishDecodable(type: Page<DayOfTheWeek>.self)
    }

    // MARK: - Workout Day

    var workoutDayURL: String { "\(self.baseURL)/day/" }

    func getWorkoutDays() -> DataResponsePublisher<Page<WorkoutDay>> {
        return session.request(self.workoutDayURL)
            .validate()
            .publishDecodable(type: Page<WorkoutDay>.self)
    }

    func createWorkoutDay(workoutId: Int, description: String, days: [Int]) -> DataResponsePublisher<WorkoutDay> {
        return session.request(self.workoutDayURL,
                               method: .post,
                               parameters: WorkoutDay(id: 0,
                                                      training: workoutId,
                                                      description: description,
                                                      day: days),
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: WorkoutDay.self)
    }

    // MARK: - Exercise

    var exerciseURL: String { "\(self.baseURL)/exercise/" }

    func getExercise(by term: String) -> AnyPublisher<[SearchExercise.Data], AFError> {
        return session.request("\(self.exerciseURL)/search/",
                               parameters: ["term": term])
            .validate()
            .publishDecodable(type: Search<SearchExercise>.self)
            .value()
            .map { search in
                return search.suggestions?.compactMap { $0.data } ?? []
            }
            .eraseToAnyPublisher()
    }
}
