//
//  LanguageViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/9/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class LanguagesViewModel: ObservableObject {

    @Published var languages: Page<Language>?

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NetLanguages = Net()

    func getLanguages() {
        net.getLanguages()
            .sink { response in
                debugPrint(response)
            }
            .store(in: &cancellableSet)
    }
}
