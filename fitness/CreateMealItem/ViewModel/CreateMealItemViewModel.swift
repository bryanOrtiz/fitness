//
//  CreateMealItemViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/8/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class CreateMealItemViewModel: ObservableObject {

    // MARK: - Properties

    @Published var item: NutritionPlanInfo.Meal.Item
    @Published var amount: String = "1"
    @Published var selectedItem: SearchIngredient?

    @Published var search = ""
    @Published var items = [SearchIngredient]()
    @Published var selectedIngredient: Ingredient?
    @Published var didSelectItem = false

    @Published var didComplete = false

    private var cancellableSet: Set<AnyCancellable> = []

    let net: CreateMealItemNet
    let bus: PassthroughSubject<AppEvent, Never>

    // MARK: - Initializers

    init(net: CreateMealItemNet,
         bus: PassthroughSubject<AppEvent, Never>,
         mealId: Int) {
        self.net = net
        self.bus = bus
        self.item = NutritionPlanInfo.Meal.Item(id: 0,
                                                mealId: mealId,
                                                ingredientId: 0,
                                                ingredient: nil,
                                                weightUnit: nil,
                                                weightUnitObj: nil,
                                                order: 0,
                                                amount: "1")

        self.registerSubscribers()
    }

    // MARK: - NET

    func createMealItem() {
        self.net.createMealItem(item: self.item)
            .result()
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(item):
                    self.didComplete = true
                    self.bus.send(AppEvent.didUpdateDetailedNutritionPlan(id: item.mealId))
                case let .failure(error):
                    debugPrint("error: \(error)")
                }
            }
            .store(in: &cancellableSet)
    }

    // MARK: - Register Subscribers

    private func registerSubscribers() {
        self.registerIngredientChange()
        self.registerAmountChange()
        self.registerSearchChange()
        self.registerDidSelectItem()
    }

    private func registerIngredientChange() {
        self.$selectedIngredient
            .compactMap { $0 }
            .map { self.item.ingredientId($0.id) }
            .assign(to: \.item, on: self)
            .store(in: &cancellableSet)
    }

    private func registerAmountChange() {
        self.$amount
            .map { self.item.amount($0) }
            .assign(to: \.item, on: self)
            .store(in: &cancellableSet)
    }

    private func registerSearchChange() {
        self.$search
            .debounce(for: 1, scheduler: RunLoop.main)
            .flatMap { search in
                return self.net.findIngredients(by: search)
//                    .map { result in
//                        switch result {
//                        case let .success(ingredients):
//                            return ingredients
//                        case let .failure(error):
//                            debugPrint("error: \(error)")
//                            return self.items
//                        }
//                    }
                    .assertNoFailure()
            }
            .assign(to: \.items, on: self)
            .store(in: &cancellableSet)
    }

    private func registerDidSelectItem() {
        self.$selectedItem
            .compactMap { $0 }
            .removeDuplicates()
            .flatMap { searchIngredient in
                return self.net.getDetailedIngredient(id: searchIngredient.id)
                    .result()
                    .map { result in
                        switch result {
                        case let .success(ingredient):
                            return ingredient
                        case let .failure(error):
                            debugPrint("error: \(error)")
                            return nil
                        }
                    }
            }
            .assign(to: \.selectedIngredient, on: self)
            .store(in: &cancellableSet)
    }
}
