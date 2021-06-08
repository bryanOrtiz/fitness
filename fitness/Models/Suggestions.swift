//
//  Suggestions.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Suggestions<T: Codable>: Codable {
    let suggestions: [ValueData<T>]?
}

struct ValueData<T: Codable>: Codable, Identifiable {
    let id = UUID()
    let value: String
    let data: T

    enum CodingKeys: String, CodingKey {
        case value, data
    }
}
