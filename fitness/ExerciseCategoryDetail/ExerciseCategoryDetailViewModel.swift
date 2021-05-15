//
//  ExerciseCategoryDetailViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/15/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class ExerciseCategoryDetailViewModel: ObservableObject {

    @Published var exercises = [ExerciseInfo]()

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NetExerciseInfo = Net()

    let category: ExerciseCategory

    init(category: ExerciseCategory) {
        self.category = category

        getListOfExercisesForCategory()
    }

    private func getListOfExercisesForCategory() {
        net.getExerciseInfo()
            .result()
            .map({ result in
                switch result {
                case let .success(page):
                    return page.results
                case .failure(_):
                    return []
                }
            })
            .assign(to: \.exercises, on: self)
            .store(in: &cancellableSet)
    }
}
