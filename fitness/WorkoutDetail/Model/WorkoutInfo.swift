//
//  WorkoutInfo.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

// MARK: - Workout Info

struct WorkoutInfo: Codable {
    let workout: Workout
    let days: [WorkoutInfoDay]
    let muscles: WorkoutInfoMuscle

    enum CodingKeys: String, CodingKey {
        case workout = "obj"
        case days = "day_list"
        case muscles
    }
}

// MARK: - WorkoutInfoDay

struct WorkoutInfoDay: Codable, Identifiable {
    let id = UUID()

    let day: WorkoutDay
    let daysOfTheWeek: WorkoutInfoDaysOfWeek
    let sets: [WorkoutInfoSet]
    let muscles: WorkoutInfoMuscle

    enum CodingKeys: String, CodingKey {
        case day = "obj"
        case daysOfTheWeek = "days_of_week"
        case sets = "set_list"
        case muscles
    }
}

struct WorkoutInfoDaysOfWeek: Codable {
    let day: String
    let days: [DayOfTheWeek]

    enum CodingKeys: String, CodingKey {
        case day = "text"
        case days = "day_list"
    }
}

struct WorkoutInfoSet: Codable, Identifiable {
    let id = UUID()

    let set: ExerciseSet
    let exercises: [WorkoutInfoExercise]
    let isSuperset: Bool

    enum CodingKeys: String, CodingKey {
        case set = "obj"
        case exercises = "exercise_list"
        case isSuperset = "is_superset"
    }
}

struct WorkoutInfoExercise: Codable, Identifiable {
    let id = UUID()
    let exercise: Exercise
    let text: String
    let hasWeight: Bool
    let comments: [String]
    let images: [WorkoutInfoExerciseImage]
    let settings: [Setting]

    enum CodingKeys: String, CodingKey {
        case exercise = "obj"
        case text = "setting_text"
        case hasWeight = "has_weight"
        case comments = "comment_list"
        case images = "image_list"
        case settings = "setting_obj_list"
    }
}

struct WorkoutInfoExerciseImage: Codable {
    let image: String
    let isMain: Bool

    enum CodingKeys: String, CodingKey {
        case image
        case isMain = "is_main"
    }
}

// MARK: - Shared

struct WorkoutInfoMuscle: Codable {
    let frontMuscles: [Muscle]
    let backMuscles: [Muscle]
    let frontSecondaryMuscles: [Muscle]
    let backSecondaryMuscles: [Muscle]

    enum CodingKeys: String, CodingKey {
        case frontMuscles = "front"
        case backMuscles = "back"
        case frontSecondaryMuscles = "frontsecondary"
        case backSecondaryMuscles = "backsecondary"
    }
}
