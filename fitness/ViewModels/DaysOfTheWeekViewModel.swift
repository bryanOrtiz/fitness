//
//  DaysOfTheWeekViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/9/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine

class DaysOfTheWeekViewModel: ObservableObject {

    @Published var days: Page<DayOfTheWeek>?

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NetDaysOfTheWeek = Net()

    func getDaysOfTheWeek() {
        net.getDaysOfTheWeek()
            .sink { response in
                debugPrint(response)
            }
            .store(in: &cancellableSet)
    }
}
