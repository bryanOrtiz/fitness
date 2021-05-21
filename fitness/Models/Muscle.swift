//
//  Muscle.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/9/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct Muscle: Codable, Identifiable {
    let id: Int
    let name: String
    let isFront: Bool
    let imageUrlMain: String
    let imageUrlSecondary: String

    enum CodingKeys: String, CodingKey {
        case id
        case name

        case isFront = "is_front"
        case imageUrlMain = "image_url_main"
        case imageUrlSecondary = "image_url_secondary"
    }
}
