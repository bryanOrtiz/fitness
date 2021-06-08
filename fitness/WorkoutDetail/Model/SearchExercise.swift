//
//  SearchExercise.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation

struct SearchExercise: Codable, Hashable, Identifiable {

    // MARK: - Properties

    let id: Int
    let name: String
    let category: String
    let image: String?
    let imageThumbnail: String?

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case image
        case imageThumbnail = "image_thumbnail"
    }
}
