//
//  ExerciseCategoriesViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/15/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class ExerciseCategoriesViewModel: ObservableObject {

    @Published var categories = [ExerciseCategory]()

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NetExerciseCategory = Net()

    init() {
        getCategories()
    }

    func getCategories() {
        net.getExerciseCategory()
            .map({ response in
                switch response.result {
                case let .success(page):
                    return page.results
                case .failure:
                    break
                }
                return []
            })
            .assign(to: \.categories, on: self)
            .store(in: &cancellableSet)
    }
}
