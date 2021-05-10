//
//  ExerciseComment.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/9/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct ExerciseComment: Decodable {
    let id: Int
    let exercise: String
    let comment: String
}
