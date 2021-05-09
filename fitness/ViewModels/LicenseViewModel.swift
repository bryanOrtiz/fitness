//
//  LicenseViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/8/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class LicenseViewModel: ObservableObject {

    @Published var license: Page<License>?

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NetLicense = Net()

    func getLicense() {
        net.getLicense()
            .sink { response in
                debugPrint(response)
            }
            .store(in: &cancellableSet)
    }
}
