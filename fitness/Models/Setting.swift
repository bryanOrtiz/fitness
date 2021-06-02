//
//  Setting.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/12/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Setting: Codable, Identifiable, Hashable {
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

    // MARK: - Changes

    func set(set: Int) -> Setting {
        return Setting(id: self.id,
                       set: set,
                       exercise: self.exercise,
                       repitionUnit: self.repitionUnit,
                       reps: self.reps,
                       weight: self.weight,
                       weightUnit: self.weightUnit,
                       rir: self.rir,
                       order: self.order,
                       comment: self.comment)
    }

    func exercise(exercise: Int) -> Setting {
        return Setting(id: self.id,
                       set: self.set,
                       exercise: exercise,
                       repitionUnit: self.repitionUnit,
                       reps: self.reps,
                       weight: self.weight,
                       weightUnit: self.weightUnit,
                       rir: self.rir,
                       order: self.order,
                       comment: self.comment)
    }

    func repitionUnit(repitionUnit: Int) -> Setting {
        return Setting(id: self.id,
                       set: self.set,
                       exercise: self.exercise,
                       repitionUnit: repitionUnit,
                       reps: self.reps,
                       weight: self.weight,
                       weightUnit: self.weightUnit,
                       rir: self.rir,
                       order: self.order,
                       comment: self.comment)
    }

    func reps(reps: Int) -> Setting {
        return Setting(id: self.id,
                       set: self.set,
                       exercise: self.exercise,
                       repitionUnit: self.repitionUnit,
                       reps: reps,
                       weight: self.weight,
                       weightUnit: self.weightUnit,
                       rir: self.rir,
                       order: self.order,
                       comment: self.comment)
    }

    func weight(weight: String) -> Setting {
        return Setting(id: self.id,
                       set: self.set,
                       exercise: self.exercise,
                       repitionUnit: self.repitionUnit,
                       reps: self.reps,
                       weight: weight,
                       weightUnit: self.weightUnit,
                       rir: self.rir,
                       order: self.order,
                       comment: self.comment)
    }

    func weightUnit(weightUnit: Int) -> Setting {
        return Setting(id: self.id,
                       set: self.set,
                       exercise: self.exercise,
                       repitionUnit: self.repitionUnit,
                       reps: self.reps,
                       weight: self.weight,
                       weightUnit: weightUnit,
                       rir: self.rir,
                       order: self.order,
                       comment: self.comment)
    }
}
