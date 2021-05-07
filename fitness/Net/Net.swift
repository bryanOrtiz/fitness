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

struct Net1: NetBase {
    let authorization = "Token de69a1643b4f99be3fb7387f26aab4cd19f9d73e"
    let baseURL = "https://wger.de/api/v2/"
}

enum Router: URLRequestConvertible {
    case getDaysOfTheWeek
    case getLanguages
    
    var baseURL: URL {
        return URL(string: "https://wger.de/api/v2/")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDaysOfTheWeek, .getLanguages: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDaysOfTheWeek: return "daysofweek"
        case .getLanguages: return "language"
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
    func getDaysOfTheWeek() -> DataRequest
}

extension Net1: NetDaysOfTheWeek {
    func getDaysOfTheWeek() -> DataRequest {
        return AF.request(Router.getDaysOfTheWeek)
            .validate()
            .responseDecodable(of: Page<DayOfTheWeek>.self) { _ in }
    }
}

// MARK: - Languages

protocol NetLanguages {
    func getLanguages() -> DataRequest
}

extension Net1: NetLanguages {
    func getLanguages() -> DataRequest {
        return AF.request(Router.getLanguages)
            .validate()
            .responseDecodable(of: Page<Language>.self) { _ in }
    }
}

protocol NetLicense {
    func getLicense() -> DataRequest
}

protocol NetUserProfile {
    func getUserProfile() -> DataRequest
}

protocol NetSettingRepitionUnit {
    func getSettingRepitionUnit() -> DataRequest
}

protocol NetSettingWeightUnit {
    func getSettingWeightUnit() -> DataRequest
}

protocol NetExerciseInfo {
    func getExerciseInfo() -> DataRequest
}

protocol NetExercise {
    func getExercise() -> DataRequest
}

protocol NetEquipment {
    func getEquipment() -> DataRequest
}

protocol NetExerciseCategory {
    func getExerciseCategory() -> DataRequest
}

protocol NetExerciseImage {
    func getExerciseImage() -> DataRequest
    // requires exercise, image
    func createExerciseImage() -> DataRequest
}

protocol NetExerciseComment {
    func getExerciseComment() -> DataRequest
}

protocol NetMuscle {
    func getMuscle() -> DataRequest
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

struct Net {
    
    let authorization = HTTPHeader.authorization("Token de69a1643b4f99be3fb7387f26aab4cd19f9d73e")
    
    func getUserProfile() -> AnyPublisher<UserProfile, AFError> {
        let headers: HTTPHeaders = [
            authorization
        ]
        return AF.request("https://wger.de/api/v2/userprofile/", headers: headers)
            .validate()
            .publishDecodable(type: UserProfile.self)
//            .result()
            .value()
    }
    
    func getUserProfileOldSchool() -> DataRequest {
        let headers: HTTPHeaders = [
            authorization
        ]
        return AF.request("https://wger.de/api/v2/userprofile/", headers: headers)
            .validate()
            .responseDecodable(of: UserProfiles.self) { response in
                print(response)
            }
    }
}
