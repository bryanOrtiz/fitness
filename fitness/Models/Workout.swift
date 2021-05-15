//
//  Workout.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/12/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Workout: Codable {
    let id: Int
    let creationDate: String
    let name: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case creationDate = "creation_date"
    }
}
