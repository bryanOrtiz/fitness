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
    @Binding var bmr: Double

    @State private var selectedMeasurementSystem = MeasurementSystem.imperial
    @State private var selectedGender = Gender.male
    @State private var age: Double = 0
    @State private var height: Double = 0
    @State private var weight: Double = 0

    @State private var isExpanded = false

    // MARK: - UI

    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                Picker("", selection: $selectedMeasurementSystem) {
                    ForEach(MeasurementSystem.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Picker("", selection: $selectedGender) {
                    ForEach(Gender.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                AgeView(age: Binding<Double>(get: { self.age },
                                             set: { newAge in
                                                age = newAge
                                                calculate()
                                             }))
                HeightView(measurementSystem: selectedMeasurementSystem,
                           height: Binding<Double>(get: { self.height },
                                                   set: { newHeight in
                                                    height = newHeight
                                                    calculate()
                                                   }))
                WeightView(measurementSystem: selectedMeasurementSystem,
                           weight: Binding<Double>(get: { self.weight },
                                                   set: { newWeight in
                                                    weight = newWeight
                                                    calculate()
                                                   }))
            },
            label: {
                DailyCaloricIntakeLabelView(title: "Basal Metabolic Rate",
                                            description: "The basal metabolic rate is the amount of energy expended " +
                                                "daily at rest. This is the minimum energy needed for the body to " +
                                                "function, without any additional physical activity.",
                                            valueTitle: "Your BMR is:",
                                            valueText: "\(bmr)")
            }
        )
    }

    // MARK: - Actions

    func calculate() {
        if selectedGender == .male {
            bmr = (4.799 * height + 13.397 * weight - 5.677 * age + 88.326)
        } else if selectedGender == .female {
            bmr = (3.098 * height + 9.247 * weight - 4.33 * age + 447.593)
        }
    }
}
