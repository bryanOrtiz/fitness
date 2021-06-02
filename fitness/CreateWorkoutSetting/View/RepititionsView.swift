//
//  RepititionsView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/31/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct RepititionsView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: CreateWorkoutSettingViewModel

    @Binding var numberOfSets: Int
    @Binding var setsRepating: SetsRepeating
    @Binding var numberOfRepitions: Int
    @Binding var weight: Double
    @Binding var selectedIndex: Int

    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    // MARK: - UI

    var body: some View {

        if !self.viewModel.settingWeightUnits.isEmpty {
            VStack(alignment: .leading) {
                let range = 1...(self.setsRepating == .repeating ? 1 : self.numberOfSets)
                ForEach(range, id: \.self) { int in
                    Section(header: Text("Set \(int)")
                                .font(.headline)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Reps")
                                    .font(.subheadline)
                                TextField("Enter number of reps",
                                          value: $numberOfRepitions,
                                          formatter: self.formatter)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            VStack(alignment: .leading) {
                                Text("Weight")
                                    .font(.subheadline)
                                TextField("Enter weight",
                                          value: $weight,
                                          formatter: self.decimalFormatter)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            Menu {
                                ForEach(self.viewModel.settingWeightUnits) { unit in
                                    Button(unit.name, action: { self.viewModel.selectedSettingWeightUnits = unit })
                                }
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("Unit")
                                        .font(.subheadline)
                                    TextField("", text: Binding<String>(
                                                get: { self.viewModel.selectedSettingWeightUnits.name },
                                                set: { _ in }))
                                        .keyboardType(.decimalPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                            }
                            .foregroundColor(.black)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                }
//                Picker(selection: $selectedIndex,
//                       label: Text("")) {
//                    ForEach(self.viewModel.settingRepUnits.indices) {
//                        Text(self.viewModel.settingRepUnits[$0].name)
//                    }
//                }
            }// .padding()
        } else {
            EmptyView()
        }
    }
}
