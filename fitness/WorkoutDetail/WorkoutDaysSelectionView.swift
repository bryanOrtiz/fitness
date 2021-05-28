//
//  WorkoutDaysSelectionView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI
import Combine

/// Needed another data type here so that we can bind when something is selected
struct BindingDayOfTheWeek: Identifiable, Hashable {
    var id: String { day.id }

    let day: DayOfTheWeek
    var isSelected: Bool = false
}

struct WorkoutDaysSelectionView: View {

    // MARK: - Properties
    @EnvironmentObject private var viewModel: WorkoutDetailViewModel

    // MARK: - UI

    var body: some View {
        LazyVStack {
            ForEach(self.viewModel.daysOfTheWeek) { bindingDay in
                let binding = Binding<Bool>(
                    get: { bindingDay.isSelected },
                    set: { newVal in
                        guard let index = self.viewModel.daysOfTheWeek.firstIndex(of: bindingDay) else { return }
                        var newDay = bindingDay
                        newDay.isSelected = newVal
                        self.viewModel.daysOfTheWeek[index] = newDay
                    }
                )
                MultipleSelectionViewItem(title: bindingDay.day.day,
                                          isSelected: binding)
            }
        }
    }
}
