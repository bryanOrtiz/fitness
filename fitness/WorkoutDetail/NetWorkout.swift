//
//  NetWorkout.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/17/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Workout

protocol NetWorkout {
    func getWorkout() -> DataResponsePublisher<Page<Workout>>

    func createWorkout(name: String,
                       description: String) -> DataResponsePublisher<Workout>

    func editWorkout(id: Int,
                     name: String,
                     description: String) -> DataResponsePublisher<Workout>
}

extension Net: NetWorkout {

    func getWorkout() -> DataResponsePublisher<Page<Workout>> {
        return session.request(self.baseURL + "workout/")
            .validate()
            .publishDecodable(type: Page<Workout>.self)
    }

    func createWorkout(name: String,
                       description: String) -> DataResponsePublisher<Workout> {
        return session.request(self.baseURL + "workout/",
                               method: .post,
                               parameters: ["name": name, "description": description],
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: Workout.self)
    }

    func editWorkout(id: Int,
                     name: String,
                     description: String) -> DataResponsePublisher<Workout> {
        return session.request(self.baseURL + "workout/\(id)/",
                               method: .patch,
                               parameters: ["name": name, "description": description],
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: Workout.self)
    }
}
