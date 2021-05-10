//
//  Net.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/3/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import Combine

// MARK: - Base

protocol NetBase {
    var authorization: String { get }
    var baseURL: String { get }
}

struct Net: NetBase {
    let authorization = "Token de69a1643b4f99be3fb7387f26aab4cd19f9d73e"
    let baseURL = "https://wger.de/api/v2/"
}

enum Router: URLRequestConvertible {
    case getDaysOfTheWeek
    case getLanguages
    case getLicense
    case getUserProfile
    case getSettingRepetitionUnit
    case getSettingWeightUnit
    case getExerciseInfo
    case getExercise
    case getEquipment
    case getExerciseCategory
    case getExerciseComment
    case getMuscle

    var baseURL: URL {
        return URL(string: "https://wger.de/api/v2/")!
    }

    var method: HTTPMethod {
        switch self {
        case .getDaysOfTheWeek,
             .getLanguages,
             .getLicense,
             .getUserProfile,
             .getSettingRepetitionUnit,
             .getSettingWeightUnit,
             .getExerciseInfo,
             .getExercise,
             .getEquipment,
             .getExerciseCategory,
             .getExerciseComment,
             .getMuscle: return .get
        }
    }

    var path: String {
        switch self {
        case .getDaysOfTheWeek: return "daysofweek"
        case .getLanguages: return "language"
        case .getLicense: return "license"
        case .getUserProfile: return "userprofile"
        case .getSettingRepetitionUnit: return "setting-repetitionunit"
        case .getSettingWeightUnit: return "setting-weightunit"
        case .getExerciseInfo: return "exerciseinfo"
        case .getExercise: return "exercise"
        case .getEquipment: return "equipment"
        case .getExerciseCategory: return "exercisecategory"
        case .getExerciseComment: return "exercisecomment"
        case .getMuscle: return "muscle"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = [
            HTTPHeader.authorization("Token de69a1643b4f99be3fb7387f26aab4cd19f9d73e")
        ]

        return request
    }
}

// MARK: Route

protocol NetRoute: NetBase {
    var route: String { get }
}

// MARK: - Day

protocol NetDay {
    func getDay() -> DataRequest
    // requires training, description, day
    func createDay() -> DataRequest
}

protocol NetSet {
    func getSet() -> DataRequest
    // requires Day
    func createSet() -> DataRequest
}

protocol NetSetting {
    func getSetting() -> DataRequest
    // requires setting, exercise, reps
    func createSetting() -> DataRequest
}

protocol NetWorkout {
    func getWorkout() -> DataRequest
    // requires setting, exercise, reps
    func createWorkout() -> DataRequest
}

protocol NetWorkoutSession {
    func getWorkoutSession() -> DataRequest
    // requires workout, date
    func createWorkoutSession() -> DataRequest
}

protocol NetWorkoutLog {
    func getWorkoutLog() -> DataRequest
    // requires reps, weight, date, exercise, workout
    func createWorkoutLog() -> DataRequest
}

protocol NetScheduleStep {
    func getScheduleStep() -> DataRequest
    // requires schedule, workout
    func createScheduleStep() -> DataRequest
}

protocol NetSchedule {
    func getSchedule() -> DataRequest
    // requires name
    func createSchedule() -> DataRequest
}

// MARK: - DaysOfTheWeek

protocol NetDaysOfTheWeek {
    func getDaysOfTheWeek() -> DataResponsePublisher<Page<DayOfTheWeek>>
}

extension Net: NetDaysOfTheWeek {
    func getDaysOfTheWeek() -> DataResponsePublisher<Page<DayOfTheWeek>> {
        return AF.request(Router.getDaysOfTheWeek)
            .validate()
            .publishDecodable(type: Page<DayOfTheWeek>.self)
    }
}

// MARK: - Languages

protocol NetLanguages {
    func getLanguages() -> DataResponsePublisher<Page<Language>>
}

extension Net: NetLanguages {
    func getLanguages() -> DataResponsePublisher<Page<Language>> {
        return AF.request(Router.getLanguages)
            .validate()
            .publishDecodable(type: Page<Language>.self)
    }
}

// MARK: - License

protocol NetLicense {
    func getLicense() -> DataResponsePublisher<Page<License>>
}

extension Net: NetLicense {
    func getLicense() -> DataResponsePublisher<Page<License>> {
        return AF.request(Router.getLicense)
            .validate()
            .publishDecodable(type: Page<License>.self)
    }
}

// MARK: - User Profile

protocol NetUserProfile {
    func getUserProfile() -> DataResponsePublisher<Page<UserProfile>>
}

extension Net: NetUserProfile {
    func getUserProfile() -> DataResponsePublisher<Page<UserProfile>> {
        return AF.request(Router.getUserProfile)
            .validate()
            .publishDecodable(type: Page<UserProfile>.self)
    }
}

// MARK: - Repition Unit

protocol NetSettingRepetitionUnit {
    func getSettingRepetitioUnit() -> DataResponsePublisher<Page<SettingsRepetitionUnit>>
}

extension Net: NetSettingRepetitionUnit {
    func getSettingRepetitioUnit() -> DataResponsePublisher<Page<SettingsRepetitionUnit>> {
        return AF.request(Router.getSettingRepetitionUnit)
            .validate()
            .publishDecodable(type: Page<SettingsRepetitionUnit>.self)
    }
}

// MARK: - Weight Unit

protocol NetSettingWeightUnit {
    func getSettingWeightUnit() -> DataResponsePublisher<Page<SettingsWeightUnit>>
}

extension Net: NetSettingWeightUnit {
    func getSettingWeightUnit() -> DataResponsePublisher<Page<SettingsWeightUnit>> {
        return AF.request(Router.getSettingWeightUnit)
            .validate()
            .publishDecodable(type: Page<SettingsWeightUnit>.self)
    }
}

// MARK: - Exercise Info

protocol NetExerciseInfo {
    func getExerciseInfo() -> DataResponsePublisher<Page<ExerciseInfo>>
}

extension Net: NetExerciseInfo {
    func getExerciseInfo() -> DataResponsePublisher<Page<ExerciseInfo>> {
        return AF.request(Router.getExerciseInfo)
            .validate()
            .publishDecodable(type: Page<ExerciseInfo>.self)
    }
}

// MARK: - Exercise

protocol NetExercise {
    func getExercise() -> DataResponsePublisher<Page<Exercise>>
}

extension Net: NetExercise {
    func getExercise() -> DataResponsePublisher<Page<Exercise>> {
        return AF.request(Router.getExercise)
            .validate()
            .publishDecodable(type: Page<Exercise>.self)
    }
}

// MARK: - Equipment

protocol NetEquipment {
    func getEquipment() -> DataResponsePublisher<Page<Equipment>>
}

extension Net: NetEquipment {
    func getEquipment() -> DataResponsePublisher<Page<Equipment>> {
        return AF.request(Router.getEquipment)
            .validate()
            .publishDecodable(type: Page<Equipment>.self)
    }
}

// MARK: - Exercise Category

protocol NetExerciseCategory {
    func getExerciseCategory() -> DataResponsePublisher<Page<ExerciseCategory>>
}

extension Net: NetExerciseCategory {
    func getExerciseCategory() -> DataResponsePublisher<Page<ExerciseCategory>> {
        return AF.request(Router.getExerciseCategory)
            .validate()
            .publishDecodable(type: Page<ExerciseCategory>.self)
    }
}

// MARK: - Exercise Image

protocol NetExerciseImage {
    func getExerciseImage() -> DataRequest
    // requires exercise, image
    func createExerciseImage() -> DataRequest
}

// MARK: - Exercise Comment

protocol NetExerciseComment {
    func getExerciseComment() -> DataResponsePublisher<Page<ExerciseComment>>
}

extension Net: NetExerciseComment {
    func getExerciseComment() -> DataResponsePublisher<Page<ExerciseComment>> {
        return AF.request(Router.getExerciseComment)
            .validate()
            .publishDecodable(type: Page<ExerciseComment>.self)
    }
}

// MARK: - Muscle

protocol NetMuscle {
    func getMuscle() -> DataResponsePublisher<Page<Muscle>>
}

extension Net: NetMuscle {
    func getMuscle() -> DataResponsePublisher<Page<Muscle>> {
        return AF.request(Router.getMuscle)
            .validate()
            .publishDecodable(type: Page<Muscle>.self)
    }
}

protocol NetIngredient {
    func getIngredient() -> DataRequest
}

protocol NetIngredientInfo {
    func getIngredientInfo() -> DataRequest
}

protocol NetWeightUnit {
    func getWeightUnit() -> DataRequest
}

protocol NetIngredientWeightUnit {
    func getIngredientWeightUnit() -> DataRequest
}

protocol NetNutritionPlan {
    func getNutritionPlan() -> DataRequest
    func createNutritionPlan() -> DataRequest
}

protocol NetNutritionPlanInfo {
    func getNutritionPlanInfo() -> DataRequest
    // requires meals
    func createNutritionPlanoInfo() -> DataRequest
}

protocol NetNutritionDiary {
    func getNutritionDiary() -> DataRequest
    // requires plan, ingredient, amount
    func createNutritionDiary() -> DataRequest
}

protocol NetMeal {
    func getMeal() -> DataRequest
    // requires plan
    func createMeal() -> DataRequest
}

protocol NetMealItems {
    func getMealItems() -> DataRequest
    // requires meal, ingredient, amount
    func createMealItem() -> DataRequest
}

protocol NetWeightEntry {
    func getWeightEntry() -> DataRequest
    // requires date, weight
    func creatWeightEntry() -> DataRequest
}
