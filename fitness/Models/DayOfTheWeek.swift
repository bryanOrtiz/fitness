//
//  DayOfTheWeek.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/6/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct DayOfTheWeek: Codable {

    let day: String
    
    enum CodingKeys: String, CodingKey {
        case day = "day_of_week"
    }
}
