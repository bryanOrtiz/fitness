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

    // MARK: - Properties
    @Published var categories = [ExerciseCategory]()
    @Published var muscles = [Muscle]()
    @Published var equipment = [Equipment]()

    private var cancellableSet: Set<AnyCancellable> = []

    private let net: NetExerciseCategory & NetMuscle & NetEquipment = Net()

    // MARK: - Initializers

    init() {
        getCategories()
        getMuscles()
        getEquipment()
    }

    // MARK: - Network
    private func getCategories() {
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

    private func getMuscles() {
        net.getMuscle()
            .map({ response in
                switch response.result {
                case let .success(page):
                    return page.results
                case .failure:
                    break
                }
                return []
            })
            .assign(to: \.muscles, on: self)
            .store(in: &cancellableSet)
    }

    private func getEquipment() {
        net.getEquipment()
            .map({ response in
                switch response.result {
                case let .success(page):
                    return page.results
                case .failure:
                    break
                }
                return []
            })
            .assign(to: \.equipment, on: self)
            .store(in: &cancellableSet)
    }
}
