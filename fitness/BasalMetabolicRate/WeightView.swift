//
//  WeightView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/22/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct WeightView: View {

    // MARK: - Properties
    let measurementSystem: MeasurementSystem
    let weightCalculated: (_ weight: Double) -> Void

    @State private var pounds = Measurement(value: 0,
                                            unit: UnitMass.pounds)
    @State private var kilograms = Measurement(value: 0,
                                            unit: UnitMass.kilograms)

    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        return formatter
    }()

    // MARK: - UI

    var body: some View {
        var weightTest: Binding<String>

        if measurementSystem == .imperial {
            weightTest = Binding<String>(
                get: { self.formatter.string(for: self.pounds.value) ?? "" },
                set: { measurementStr in
                    guard !measurementStr.isEmpty, let val = Double(measurementStr) else { return }
                    pounds = Measurement(value: val,
                                         unit: UnitMass.pounds)
                    let weightKilograms = pounds.converted(to: UnitMass.kilograms)
                    weightCalculated(weightKilograms.value)
                })
        } else {
            weightTest = Binding<String>(
                get: { self.formatter.string(for: self.kilograms.value) ?? "" },
                set: { measurementStr in
                    guard !measurementStr.isEmpty, let val = Double(measurementStr) else { return }
                    kilograms = Measurement(value: val,
                                         unit: UnitMass.pounds)
                    weightCalculated(kilograms.value)
                })
        }

        return VStack(alignment: .leading) {
            Text("Weight")
                .font(.callout)
            HStack {
                TextField("0",
                          text: weightTest)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                Text(measurementSystem == .imperial ? UnitMass.pounds.symbol : UnitMass.kilograms.symbol)
            }
        }
    }
}

struct ImperialWeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView(measurementSystem: MeasurementSystem.imperial, weightCalculated: { _ in })
    }
}
