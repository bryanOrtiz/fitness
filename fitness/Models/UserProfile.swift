//
//  UserProfile.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/3/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct UserProfile: Decodable {

    let user: Int
    let gym: String?
    let is_temporary: Bool
    let show_comments: Bool
    let show_english_ingredients: Bool
    let workout_reminder_active: Bool
    let workout_reminder: Int
    let workout_duration: Int
    let last_workout_notification: String?
    let notification_language:Int
    let timer_active: Bool
    let age: String?
    let birthdate: String?
    let height: String?
    let gender: String
    let sleep_hours: Int
    let work_hours: Int
    let work_intensity: String
    let sport_hours: Int
    let sport_intensity: String
    let freetime_hours: Int
    let freetime_intensity: String
    let calories: Int
    let weight_unit: String
    let ro_access: Bool
    let num_days_weight_reminder: Int
}

struct UserProfiles: Decodable {
    
    let count: Int
    let next: Int?
    let previous: Int?
    let results: [UserProfile]
}
