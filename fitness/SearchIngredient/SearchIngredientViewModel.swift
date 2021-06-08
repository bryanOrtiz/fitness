//
//  SearchIngredientViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class SearchIngredientViewModel: ObservableObject {

    // MARK: - Properties

    @Published var search = ""
    @Published var items = [SearchIngredient]()

    private var cancellableSet: Set<AnyCancellable> = []

    let net: SearchIngredientNet

    // MARK: - Initializers

    init(net: SearchIngredientNet) {
        self.net = net

        self.registerSubscribers()
    }

    // MARK: - NET

    // MARK: - Subscribers

    private func registerSubscribers() {
        self.registerSearchChange()
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
}
