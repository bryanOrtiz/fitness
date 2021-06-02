//
//  NumberOfSetsView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/31/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct NumberOfSetsView: View {

    @EnvironmentObject var viewModel: CreateWorkoutSettingViewModel

    // MARK: - Properties

    let step = 1
    let range = 1...10

    // MARK: - UI
    var body: some View {
        Stepper(value: Binding<Int>(get: {
            self.viewModel.set.sets
        }, set: { newVal in
            self.viewModel.set = self.viewModel.set.sets(sets: newVal)
        }),
                in: range,
                step: step) {
            Text("Sets: \(self.viewModel.set.sets)")
        }
    }
}
