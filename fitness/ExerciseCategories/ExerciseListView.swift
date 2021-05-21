//
//  ExerciseListView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/15/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

enum ExerciseFilter: String, CaseIterable, Identifiable {
    case category = "Category"
    case mucsle = "Muscle"
    case equipment = "Equipment"

    var id: String { self.rawValue }
}

struct ExerciseListView: View {

    // MARK: - Properties

    @State private var selectedFilter = ExerciseFilter.category

    // MARK: - UI

    var body: some View {
        List {
            Section(header:
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(ExerciseFilter.allCases, id: \.self) { filter in
                                Text(filter.rawValue)
                            }

                        }
                        .pickerStyle(SegmentedPickerStyle())
            ) {
                ExerciseListFilteredView(filter: selectedFilter)
            }
        }.navigationBarTitle(Text("Exercises"))
    }
}

struct Exercises_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}
