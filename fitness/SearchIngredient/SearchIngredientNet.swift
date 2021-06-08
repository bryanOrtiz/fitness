//
//  SearchIngredientNet.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import Combine

protocol SearchIngredientNet {

    func findIngredients(by term: String) -> AnyPublisher<[SearchIngredient], AFError>
}

extension Net: SearchIngredientNet {

    var ingredientURL: String { "\(self.baseURL)ingredient/" }

    func findIngredients(by term: String) -> AnyPublisher<[SearchIngredient], AFError> {
        return session.request("\(self.ingredientURL)search/",
                               parameters: ["term": term])
            .validate()
            .publishDecodable(type: Suggestions<SearchIngredient>.self)
            .value()
            .map { suggestions -> [SearchIngredient] in
                return suggestions.suggestions?.compactMap({ $0.data }) ?? []
            }
            .eraseToAnyPublisher()
    }
}
