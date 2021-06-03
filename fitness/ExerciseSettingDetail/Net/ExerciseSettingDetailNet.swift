//
//  ExerciseSettingDetailNet.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/2/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import Combine

protocol ExerciseSettingDetailNet {

    // MARK: - ExerciseSetting

    var exerciseSettingURL: String { get }

    func edit(setting: Setting) -> AnyPublisher<Setting, AFError>

    func delete(id: Int) -> AnyPublisher<Void, AFError>
}

extension Net: ExerciseSettingDetailNet {

    func delete(id: Int) -> AnyPublisher<Void, AFError> {
        return session.request(self.exerciseSettingURL + "\(id)/",
                               method: .delete)
            .validate()
            .publishData()
            .value()
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    func edit(setting: Setting) -> AnyPublisher<Setting, AFError> {
        return session.request(self.exerciseSettingURL + "\(setting.id)/",
                               method: .put,
                               parameters: setting,
                               encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: Setting.self)
            .value()
    }
}
