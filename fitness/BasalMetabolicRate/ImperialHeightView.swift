//
//  ImperialHeightView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/22/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ImperialHeightView: View {

    // MARK: - Properties
    let measurementSystem: MeasurementSystem
    let heightCalculated: (_ height: Double) -> Void

    @State private var feet = Measurement(value: 0,
                                          unit: UnitLength.feet)
    @State private var inches = Measurement(value: 0,
                                            unit: UnitLength.inches)
    @State private var centimeters = Measurement(value: 0,
                                            unit: UnitLength.centimeters)

    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    // MARK: - UI
    var body: some View {

        let feetBinding = Binding<String>(
            get: { self.formatter.string(for: self.feet.value) ?? "" },
            set: { measurementStr in
                guard !measurementStr.isEmpty, let val = Double(measurementStr) else { return }
                self.feet = Measurement(value: val,
                                        unit: UnitLength.feet)
                calculateInches()
            })

        let inchesBinding = Binding<String>(
            get: { self.formatter.string(for: self.inches.value) ?? "" },
            set: { measurementStr in
                guard !measurementStr.isEmpty, let val = Double(measurementStr) else { return }
                self.inches = Measurement(value: val,
                                          unit: UnitLength.inches)
                calculateInches()
            })

        let centimetersBinding = Binding<String>(
            get: {
                self.formatter.string(for: self.inches.value) ?? ""
            },
            set: { measurementStr in
                guard !measurementStr.isEmpty, let val = Double(measurementStr) else { return }
                self.centimeters = Measurement(value: val,
                                          unit: UnitLength.centimeters)
                heightCalculated(self.centimeters.value)
            })

        return VStack(alignment: .leading) {
            Text("Height")
                .font(.callout)
            HStack {
                if measurementSystem == .imperial {
                    HStack {
                        TextField("0",
                                  text: feetBinding)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        Text(UnitLength.feet.symbol)
                    }
                    Spacer()
                    HStack {
                        TextField("0",
                                  text: inchesBinding)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        Text(UnitLength.inches.symbol)
                    }
                } else if measurementSystem == .metric {
                    HStack {
                        TextField("0",
                                  text: centimetersBinding)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        Text(UnitLength.centimeters.symbol)
                    }
                }
            }
        }
    }

    // MARK: - Actions
    private func calculateInches() {
        let feetToInches = feet.converted(to: UnitLength.inches)
        let totalInches = feetToInches + inches
        let heightCentimeters = totalInches.converted(to: UnitLength.centimeters)
        heightCalculated(heightCentimeters.value)
    }
}

struct ImperialHeightView_Previews: PreviewProvider {
    static var previews: some View {
        ImperialHeightView(measurementSystem: .imperial, heightCalculated: { _ in })
    }
}
