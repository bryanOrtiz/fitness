//
//  Page.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/6/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

// struct Page<T: Codable & Identifiable>: Codable, Identifiable {
//    let id = UUID()
//
//    let count: Int
//    let next: Int?
//    let previous: Int?
//    let results: [T]
// }

struct Page<T: Codable>: Codable {
    let count: Int
    let next: String?
    let previous: Int?
    let results: [T]
}
