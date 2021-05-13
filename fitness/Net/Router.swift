//
//  Router.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/12/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

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
    case getIngredients
    case getIngredientInfo
    case getWeightUnit
    case getIngredientWeightUnit
    case getNutritionPlan
    case getNutritionPlanInfo
    case getNutritionDiary
    case getMeals
    case getMealItems
    case getWeightEntry
    case getDay
    case getSet
    case getSetting
    case getWorkout

    case createNutritionPlan
    case createNutritionPlanInfo
    case createNutritionDiary
    case createMeal
    case createMealItem
    case createWeightEntry
    case createDay(description: String, day: DayOfTheWeek)
    case createSet(day: DayOfTheWeek)
    case createSetting(set: Set, exercise: Exercise, reps: Int)
    case createWorkout

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
             .getMuscle,
             .getIngredients,
             .getIngredientInfo,
             .getWeightUnit,
             .getIngredientWeightUnit,
             .getNutritionPlan,
             .getNutritionPlanInfo,
             .getNutritionDiary,
             .getMeals,
             .getMealItems,
             .getWeightEntry,
             .getDay,
             .getSet,
             .getSetting,
             .getWorkout: return .get
        case .createNutritionPlan,
             .createNutritionPlanInfo,
             .createNutritionDiary,
             .createMeal,
             .createMealItem,
             .createWeightEntry,
             .createDay(_, _),
             .createSet(_),
             .createSetting(_, _, _),
             .createWorkout: return .post
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
        case .getIngredients: return "ingredient"
        case .getIngredientInfo: return "ingredientinfo"
        case .getWeightUnit: return "weightunit"
        case .getIngredientWeightUnit: return "ingredientweightunit"
        case .getNutritionPlan, .createNutritionPlan: return "nutritionplan"
        case .getNutritionPlanInfo, .createNutritionPlanInfo: return "nutritionplaninfo"
        case .getNutritionDiary, .createNutritionDiary: return "nutritiondiary"
        case .getMeals, .createMeal: return "meal"
        case .getMealItems, .createMealItem: return "mealitem"
        case .getWeightEntry, .createWeightEntry: return "weightentry"
        case .getDay, .createDay(_, _): return "day"
        case .getSet, .createSet(_): return "set"
        case .getSetting, .createSetting(_, _, _): return "setting"
        case .getWorkout, .createWorkout: return "workout"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = [
            HTTPHeader.authorization("Token de69a1643b4f99be3fb7387f26aab4cd19f9d73e")
        ]

        switch self {
//                case let .get(parameters):
//                    request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        case let .createDay(description, day):
                    request = try JSONParameterEncoder().encode(["day": day], into: request)
                    request = try JSONParameterEncoder().encode(["description": description], into: request)
        case let .createSet(day):
            request = try JSONParameterEncoder().encode(["day": day], into: request)
        case let .createSetting(set, exercise, reps):
            request = try JSONParameterEncoder().encode(["set": set], into: request)
            request = try JSONParameterEncoder().encode(["exercise": exercise], into: request)
            request = try JSONParameterEncoder().encode(["reps": reps], into: request)
        default: break
                }

        return request
    }
}
