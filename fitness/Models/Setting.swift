//
//  Setting.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/12/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Setting: Codable {
    let id: Int
    let set: Int
    let exercise: Int
    let repitionUnit: Int
    let reps: Int
    let weight: String
    let weightUnit: Int
    let rir: String?
    let order: Int
    let comment: String

    enum CodingKeys: String, CodingKey {
        case id
        case set
        case exercise
        case repitionUnit = "repetition_unit"
        case reps
        case weight
        case weightUnit = "weight_unit"
        case rir
        case order
        case comment
    }
}
