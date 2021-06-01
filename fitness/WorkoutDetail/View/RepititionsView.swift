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

    @EnvironmentObject private var viewModel: WorkoutDetailViewModel

    @Binding var numberOfSets: Int
    @Binding var setsRepating: SetsRepeating
    @Binding var numberOfRepitions: Int
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

        if !self.viewModel.settingRepUnits.isEmpty {
            VStack(alignment: .leading) {
                ForEach(1...self.numberOfSets, id: \.self) { int in
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
                            VStack(alignment: .leading) {
                                Text("Weight")
                                    .font(.subheadline)
                                TextField("Enter weight",
                                          value: $numberOfRepitions,
                                          formatter: self.decimalFormatter)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                }
                Picker(selection: $selectedIndex,
                       label: Text("")) {
                    ForEach(self.viewModel.settingRepUnits.indices) {
                        Text(self.viewModel.settingRepUnits[$0].name)
                    }
                }
            }.padding()
        } else {
            EmptyView()
        }
    }
}
