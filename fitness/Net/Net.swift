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
    var baseURL: String { get }
    var session: Session { get }
}

class Net: NetBase, ObservableObject {
    let baseURL = "https://wger.de/api/v2/"
    let imgBaseURL = "https://wger.de"

    // Generally load from keychain if it exists
    @Published var credential: BasicAuthenticationCredential?

    // Create the interceptor
    let authenticator = OAuthAuthenticator()

    @Published var interceptor: AuthenticationInterceptor<OAuthAuthenticator>?

    @Published var session: Session

    // MARK: - Initializers
    init() {
        self.session = Session()

        self.$credential
            .map { [weak self] credential in
                guard let self = self, let cred = credential else { return nil }
                return AuthenticationInterceptor(authenticator: self.authenticator,
                                                 credential: cred)
            }
            .assign(to: &$interceptor)

        self.$interceptor
            .map { [unowned self] interceptor in
                guard let interceptor = interceptor else { return self.session }
                return Session(interceptor: interceptor)
            }
            .assign(to: &$session)
    }
}

// MARK: Route

protocol NetRoute: NetBase {
    var route: String { get }
}

// MARK: - Day

protocol NetDay {
    func getDay() -> DataResponsePublisher<Page<Day>>
    // requires training, description, day
    func createDay(description: String, day: DayOfTheWeek) -> DataResponsePublisher<DayOfTheWeek>
}

extension Net: NetDay {
    func getDay() -> DataResponsePublisher<Page<Day>> {
        return AF.request(Router.getDay)
            .validate()
            .publishDecodable(type: Page<Day>.self)
    }

    func createDay(description: String, day: DayOfTheWeek) -> DataResponsePublisher<DayOfTheWeek> {
        return AF.request(Router.createDay(description: description, day: day))
            .validate()
            .publishDecodable(type: DayOfTheWeek.self)
    }
}

// MARK: - Set

protocol NetSet {
    func getSet() -> DataResponsePublisher<Page<ExcerciseSet>>
    // requires Day
    func createSet(exerciseDay: DayOfTheWeek) -> DataResponsePublisher<ExcerciseSet>
}

extension Net: NetSet {
    func getSet() -> DataResponsePublisher<Page<ExcerciseSet>> {
        return AF.request(Router.getSet)
            .validate()
            .publishDecodable(type: Page<ExcerciseSet>.self)
    }

    func createSet(exerciseDay: DayOfTheWeek) -> DataResponsePublisher<ExcerciseSet> {
        return AF.request(Router.createSet(day: exerciseDay))
            .validate()
            .publishDecodable(type: ExcerciseSet.self)
    }
}

// MARK: Setting

protocol NetSetting {
    func getSetting() -> DataResponsePublisher<Page<Setting>>
    // requires set, exercise, reps
    func createSetting(set: ExcerciseSet, exercise: Exercise, reps: Int) -> DataResponsePublisher<Setting>
}

extension Net: NetSetting {
    func getSetting() -> DataResponsePublisher<Page<Setting>> {
        return AF.request(Router.getSetting)
            .validate()
            .publishDecodable(type: Page<Setting>.self)
    }
    func createSetting(set: ExcerciseSet, exercise: Exercise, reps: Int) -> DataResponsePublisher<Setting> {
        return AF.request(Router.createSetting(set: set, exercise: exercise, reps: reps))
            .validate()
            .publishDecodable(type: Setting.self)
    }
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

/// This should be used to get more detailed information
protocol NetExerciseInfo {
    func getExerciseInfo(id: Int) -> DataResponsePublisher<ExerciseInfo>
}

extension Net: NetExerciseInfo {
    func getExerciseInfo(id: Int) -> DataResponsePublisher<ExerciseInfo> {
        return AF.request(Router.getExerciseInfo(id: id))
            .validate()
            .publishDecodable(type: ExerciseInfo.self)
    }
}

// MARK: - Exercise

/// This should be used to get general information such as long lists by categories
protocol NetExercise {
    func getExercise(category: ExerciseCategory?) -> DataResponsePublisher<Page<Exercise>>
}

extension Net: NetExercise {
    func getExercise(category: ExerciseCategory?) -> DataResponsePublisher<Page<Exercise>> {
        return AF.request(Router.getExercise(category: category))
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

// MARK: - Ingredient

protocol NetIngredient {
    func getIngredients() -> DataResponsePublisher<Page<Ingredient>>
}

extension Net: NetIngredient {
    func getIngredients() -> DataResponsePublisher<Page<Ingredient>> {
        return AF.request(Router.getIngredients)
            .validate()
            .publishDecodable(type: Page<Ingredient>.self)
    }
}

// MARK: - Ingredient Info

protocol NetIngredientInfo {
    func getIngredientInfo() -> DataResponsePublisher<Page<IngredientInfo>>
}

extension Net: NetIngredientInfo {
    func getIngredientInfo() -> DataResponsePublisher<Page<IngredientInfo>> {
        return AF.request(Router.getIngredientInfo)
            .validate()
            .publishDecodable(type: Page<IngredientInfo>.self)
    }
}

// MARK: - Weight Unit

protocol NetWeightUnit {
    func getWeightUnit() -> DataResponsePublisher<Page<WeightUnit>>
}

extension Net: NetWeightUnit {
    func getWeightUnit() -> DataResponsePublisher<Page<WeightUnit>> {
        return AF.request(Router.getWeightUnit)
            .validate()
            .publishDecodable(type: Page<WeightUnit>.self)
    }
}

// MARK: - Ingredient Weight Unit

protocol NetIngredientWeightUnit {
    func getIngredientWeightUnit() -> DataResponsePublisher<Page<IngredeintWeightUnit>>
}

extension Net: NetIngredientWeightUnit {
    func getIngredientWeightUnit() -> DataResponsePublisher<Page<IngredeintWeightUnit>> {
        return AF.request(Router.getIngredientWeightUnit)
            .validate()
            .publishDecodable(type: Page<IngredeintWeightUnit>.self)
    }
}

// MARK: - Nutrition Plan Info

protocol NetNutritionPlanInfo {
    func getNutritionPlanInfo() -> DataResponsePublisher<Page<NutritionPlanInfo>>
    // requires meals
    func createNutritionPlanInfo() -> DataResponsePublisher<NutritionPlanInfo>
}

extension Net: NetNutritionPlanInfo {
    func getNutritionPlanInfo() -> DataResponsePublisher<Page<NutritionPlanInfo>> {
        return AF.request(Router.getNutritionPlanInfo)
            .validate()
            .publishDecodable(type: Page<NutritionPlanInfo>.self)
    }

    // requires meals
    func createNutritionPlanInfo() -> DataResponsePublisher<NutritionPlanInfo> {
        return AF.request(Router.createNutritionPlanInfo)
            .validate()
            .publishDecodable(type: NutritionPlanInfo.self)
    }
}

// MARK: - Nutrition Diary

protocol NetNutritionDiary {
    func getNutritionDiary() -> DataResponsePublisher<Page<NutritionDiary>>
    // requires plan, ingredient, amount
    func createNutritionDiary() -> DataResponsePublisher<NutritionDiary>
}

extension Net: NetNutritionDiary {
    func getNutritionDiary() -> DataResponsePublisher<Page<NutritionDiary>> {
        return AF.request(Router.getNutritionDiary)
            .validate()
            .publishDecodable(type: Page<NutritionDiary>.self)
    }
    // requires plan, ingredient, amount
    func createNutritionDiary() -> DataResponsePublisher<NutritionDiary> {
        return AF.request(Router.createNutritionDiary)
            .validate()
            .publishDecodable(type: NutritionDiary.self)
    }
}

// MARK: - Meal

protocol NetMeal {
    func getMeals() -> DataResponsePublisher<Page<Meal>>
    // requires plan
    func createMeal() -> DataResponsePublisher<Meal>
}

extension Net: NetMeal {
    func getMeals() -> DataResponsePublisher<Page<Meal>> {
        return AF.request(Router.getMeals)
            .validate()
            .publishDecodable(type: Page<Meal>.self)
    }
    // requires plan
    func createMeal() -> DataResponsePublisher<Meal> {
        return AF.request(Router.createMeal)
            .validate()
            .publishDecodable(type: Meal.self)
    }
}

// MARK: - Meal Items

protocol NetMealItems {
    func getMealItems() -> DataResponsePublisher<Page<MealItem>>
    // requires meal, ingredient, amount
    func createMealItem() -> DataResponsePublisher<MealItem>
}

extension Net: NetMealItems {
    func getMealItems() -> DataResponsePublisher<Page<MealItem>> {
        return AF.request(Router.getMealItems)
            .validate()
            .publishDecodable(type: Page<MealItem>.self)
    }
    // requires meal, ingredient, amount
    func createMealItem() -> DataResponsePublisher<MealItem> {
        return AF.request(Router.createMealItem)
            .validate()
            .publishDecodable(type: MealItem.self)
    }
}

// MARK: - Weigth Entry

protocol NetWeightEntry {
    func getWeightEntry() -> DataResponsePublisher<Page<WeightEntry>>
    // requires date, weight
    func createWeightEntry() -> DataResponsePublisher<WeightEntry>
}

extension Net: NetWeightEntry {
    func getWeightEntry() -> DataResponsePublisher<Page<WeightEntry>> {
        return AF.request(Router.getWeightEntry)
            .validate()
            .publishDecodable(type: Page<WeightEntry>.self)
    }
    // requires date, weight
    func createWeightEntry() -> DataResponsePublisher<WeightEntry> {
        return AF.request(Router.createWeightEntry)
            .validate()
            .publishDecodable(type: WeightEntry.self)
    }
}
