//
//  AgeView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/22/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct AgeView: View {

    // MARK: - Properties
    @Binding var age: Double

    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading) {
            Text("Age")
                .font(.callout)
            TextField("",
                      value: $age,
                      formatter: formatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .onChange(of: age, perform: { age = $0})
        }
    }
}
