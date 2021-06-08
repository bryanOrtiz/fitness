//
//  CreateWorkoutSettingNet.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/1/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import Combine

protocol CreateWorkoutSettingNet {

    // MARK: - Exercise

    var exerciseURL: String { get }

    func getExercise(by term: String) -> AnyPublisher<[SearchExercise], AFError>

    // MARK: - ExerciseSet

    var exerciseSetURL: String { get }

    func createExerciseSet(set: ExerciseSet) -> AnyPublisher<ExerciseSet, AFError>

    // MARK: - Setting Repition Unit

    var settingRepitionUnitURL: String { get }

    func getSettingRepetitioUnit() -> AnyPublisher<[SettingsRepetitionUnit], AFError>

    // MARK: - Setting Weight Unit

    var settingWeightUnitURL: String { get }

    func getSettingWeightUnit() -> AnyPublisher<[SettingsWeightUnit], AFError>

    // MARK: - ExerciseSetting

    var exerciseSettingURL: String { get }

    func createExerciseSetting(setting: Setting) -> AnyPublisher<Setting, AFError>
}

extension Net: CreateWorkoutSettingNet {

    // MARK: - Exercise

    var exerciseURL: String { "\(self.baseURL)/exercise/" }

    func getExercise(by term: String) -> AnyPublisher<[SearchExercise], AFError> {
        return session.request("\(self.exerciseURL)/search/",
                               parameters: ["term": term])
            .validate()
            .publishDecodable(type: Suggestions<SearchExercise>.self)
            .value()
            .map { search in
                return search.suggestions?.compactMap { $0.data } ?? []
            }
            .eraseToAnyPublisher()
    }

    // MARK: - ExerciseSet

    var exerciseSetURL: String { "\(self.baseURL)/set/" }

    func createExerciseSet(set: ExerciseSet) -> AnyPublisher<ExerciseSet, AFError> {
        return session.request(exerciseSetURL,
                               method: .post,
                               parameters: set,
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: ExerciseSet.self)
            .value()
            .eraseToAnyPublisher()
    }

    // MARK: - Setting Repition Unit

    var settingRepitionUnitURL: String { "\(self.baseURL)/setting-repetitionunit/" }

    func getSettingRepetitioUnit() -> AnyPublisher<[SettingsRepetitionUnit], AFError> {
        return session.request(self.settingRepitionUnitURL)
            .validate()
            .publishDecodable(type: Page<SettingsRepetitionUnit>.self)
            .value()
            .map { page in
                return page.results.map { $0 }
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Setting Repition Unit

    var settingWeightUnitURL: String { "\(self.baseURL)/setting-weightunit/" }

    func getSettingWeightUnit() -> AnyPublisher<[SettingsWeightUnit], AFError> {
        return session.request(self.settingWeightUnitURL)
            .validate()
            .publishDecodable(type: Page<SettingsWeightUnit>.self)
            .value()
            .map { page in
                return page.results.map { $0 }
            }
            .eraseToAnyPublisher()
    }

    // MARK: - ExerciseSetting

    var exerciseSettingURL: String { "\(self.baseURL)/setting/" }

    func createExerciseSetting(setting: Setting) -> AnyPublisher<Setting, AFError> {
        return session.request(exerciseSettingURL,
                               method: .post,
                               parameters: setting,
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: Setting.self)
            .value()
            .eraseToAnyPublisher()
    }
}
