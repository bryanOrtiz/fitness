//
//  UserProfile.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/3/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct UserProfile: Codable {

    let user: Int
    let gym: String?
    let isTemporary: Bool
    let showComments: Bool
    let showEnglishIngredients: Bool
    let workoutReminderActive: Bool
    let workoutReminder: Int
    let workoutDuration: Int
    let lastWorkoutNotification: String?
    let notificationLanguage: Int
    let timerActive: Bool
    let age: Int?
    let birthdate: String?
    let height: Int?
    let gender: String
    let sleepHours: Int
    let workHours: Int
    let workIntensity: String
    let sportHours: Int
    let sportIntensity: String
    let freetimeHours: Int
    let freetimeIntensity: String
    let calories: Int
    let weightUnit: String
    let roAccess: Bool
    let numDaysWeightReminder: Int

    enum CodingKeys: String, CodingKey {
        case user, gym, age, birthdate, height, gender, calories

        case isTemporary = "is_temporary"
        case showComments = "show_comments"
        case showEnglishIngredients = "show_english_ingredients"
        case workoutReminderActive = "workout_reminder_active"
        case workoutReminder = "workout_reminder"
        case workoutDuration = "workout_duration"
        case lastWorkoutNotification = "last_workout_notification"
        case notificationLanguage = "notification_language"
        case timerActive = "timer_active"
        case sleepHours = "sleep_hours"
        case workHours = "work_hours"
        case workIntensity = "work_intensity"
        case sportHours = "sport_hours"
        case sportIntensity = "sport_intensity"
        case freetimeHours = "freetime_hours"
        case freetimeIntensity = "freetime_intensity"
        case weightUnit = "weight_unit"
        case roAccess = "ro_access"
        case numDaysWeightReminder = "num_days_weight_reminder"
    }
}
