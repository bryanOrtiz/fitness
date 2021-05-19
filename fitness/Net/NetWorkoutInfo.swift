//
//  NetWorkoutInfo.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire

protocol NetWorkoutInfo {
    func getWorkout(id: Int) -> DataResponsePublisher<WorkoutInfo>
}

extension Net: NetWorkoutInfo {
    func getWorkout(id: Int) -> DataResponsePublisher<WorkoutInfo> {
        return session.request(self.baseURL + "workout/\(id)/canonical_representation/")
            .validate()
            .publishDecodable(type: WorkoutInfo.self)
    }
}
