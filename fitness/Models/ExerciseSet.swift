//
//  Set.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/12/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct ExerciseSet: Codable {
    let id: Int
    let exerciseDay: Int
    let sets: Int
    let order: Int

    enum CodingKeys: String, CodingKey {
        case id
        case exerciseDay = "exerciseday"
        case sets
        case order
    }

    // MARK: - Changes
    func sets(sets: Int) -> ExerciseSet {
        return ExerciseSet(id: self.id, exerciseDay: self.exerciseDay, sets: sets, order: self.order)
    }
}
