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

    @State private var value = 1
    let step = 1
    let range = 1...10

    // MARK: - UI
    var body: some View {
        Stepper(value: $value,
                in: range,
                step: step) {
            Text("Sets: \(value)")
        }
    }
}
