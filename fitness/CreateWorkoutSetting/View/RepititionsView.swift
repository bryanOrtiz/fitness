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

    // MARK: - UI

    var body: some View {

        if !self.viewModel.settingWeightUnits.isEmpty {
            VStack(alignment: .leading) {
                ForEach(self.viewModel.exerciseSettings) { setting in
                    Section(header: Text("Set")
                                .font(.headline)) {
                        HStack {
                            RepitionsTextView(title: "Reps",
                                              placeholderText: "Enter number of reps",
                                              text: Binding<String>(get: {
                                                return "\(setting.reps)"
                                              }, set: { newVal in
                                                let new = setting.reps(reps: Int(newVal)!)
                                                self.viewModel.updateSettings(with: new)
                                              }))
                                .keyboardType(.numberPad)
                                .frame(minWidth: 0, maxWidth: .infinity)
                            RepitionsTextView(title: "Weight",
                                              placeholderText: "Enter weight",
                                              text: Binding<String>(get: {
                                                return setting.weight
                                              }, set: { newVal in
                                                let new = setting.weight(weight: newVal)
                                                self.viewModel.updateSettings(with: new)
                                              }))
                                .keyboardType(.decimalPad)
                                .frame(minWidth: 0, maxWidth: .infinity)
                            RepititionsMenuView(title: "Unit",
                                                placeholderText: "",
                                                text: Binding<String>(
                                                    get: {
                                                        self.viewModel.getWeightUnitName(setting: setting)
                                                    },
                                                    set: { newVal in
                                                        self.viewModel.setWeightUnitName(name: newVal, setting: setting)
                                                    }),
                                                items: {
                                                    ForEach(self.viewModel.settingWeightUnits) { unit in
                                                        Button(unit.name,
                                                               action: {
                                                                self.viewModel.setWeightUnitName(name: unit.name,
                                                                                                 setting: setting)
                                                               })
                                                    }
                                                })
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}
