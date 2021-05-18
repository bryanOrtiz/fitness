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

    func createWorkout() -> DataResponsePublisher<Workout>
}

extension Net: NetWorkout {
    func getWorkout() -> DataResponsePublisher<Page<Workout>> {
        return session.request(self.baseURL + "workout/")
            .validate()
            .publishDecodable(type: Page<Workout>.self)
    }
    func createWorkout() -> DataResponsePublisher<Workout> {
        return AF.request(Router.createWorkout)
            .validate()
            .publishDecodable(type: Workout.self)
    }
}
