//
//  BasalMetabolicRate.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/21/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

enum MeasurementSystem: String, CaseIterable, Identifiable {
    case imperial = "Imperial"
    case metric = "Metric"

    var id: String { self.rawValue }
}

private enum Gender: String, CaseIterable, Identifiable {
    case male = "Male"
    case female = "Female"

    var id: String { self.rawValue }
}

struct BasalMetabolicRate: View {

    // MARK: - Properties

    @State private var selectedMeasurementSystem = MeasurementSystem.imperial
    @State private var selectedGender = Gender.male
    @State private var age: Double = 0
    @State private var height: Double = 0
    @State private var weight: Double = 0
    @State private var bmr: Double = 0

    // MARK: - UI

    var body: some View {
        VStack {
            Picker("Filter", selection: $selectedMeasurementSystem) {
                ForEach(MeasurementSystem.allCases, id: \.self) { filter in
                    Text(filter.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Picker("Filter", selection: $selectedGender) {
                ForEach(Gender.allCases, id: \.self) { filter in
                    Text(filter.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            AgeView { age = $0 }
            ImperialHeightView(measurementSystem: selectedMeasurementSystem,
                               heightCalculated: { height = $0 })
            WeightView(measurementSystem: selectedMeasurementSystem,
                       weightCalculated: { weight = $0 })
            Spacer()
            DetailRowView(title: "Your BMR is:", detail: "\(bmr)")
            Button("Calculate", action: calculate)
            .background(RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.green))
        }
    }

    // MARK: - Actions

    func calculate() {
        if selectedGender == .male {
            bmr = 4.799 * height + 13.397 * weight - 5.677 * age + 88.326
        } else if selectedGender == .female {
            bmr = 3.098 * height + 9.247 * weight - 4.33 * age + 447.593
        }
    }
}

struct BasalMetabolicRate_Previews: PreviewProvider {
    static var previews: some View {
        BasalMetabolicRate()
    }
}
