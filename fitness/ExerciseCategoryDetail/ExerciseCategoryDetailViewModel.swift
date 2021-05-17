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

    @Published var exercises = [Exercise]()

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NetExercise = Net()

    let category: ExerciseCategory

    init(category: ExerciseCategory) {
        self.category = category

        getListOfExercisesForCategory()
    }

    private func getListOfExercisesForCategory() {
        net.getExercise(category: category)
            .result()
            .map({ result in
                switch result {
                case let .success(page):
                    return page.results
                case .failure(let error):
                    debugPrint(error)
                    return []
                }
            })
            .assign(to: \.exercises, on: self)
            .store(in: &cancellableSet)
    }
}
