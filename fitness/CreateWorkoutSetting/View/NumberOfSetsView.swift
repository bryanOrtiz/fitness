//
//  NumberOfSetsView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/31/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct NumberOfSetsView: View {

    // MARK: - Properties

    @Binding var numberOfSets: Int
    let step = 1
    let range = 1...10

    // MARK: - UI
    var body: some View {
        Stepper(value: $numberOfSets,
                in: range,
                step: step) {
            Text("Sets: \(numberOfSets)")
        }
    }
}
