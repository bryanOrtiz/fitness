//
//  Day.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/11/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Day: Codable {
    let id: Int
    let training: Int
    let description: String
    let day: [Int]
}
