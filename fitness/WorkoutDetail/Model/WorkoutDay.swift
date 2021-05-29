//
//  WorkoutDay.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/11/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct WorkoutDay: Codable, Identifiable {
    let id: Int
    let training: Int
    let description: String
    let day: [Int]
}
