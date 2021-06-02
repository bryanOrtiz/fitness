//
//  ExerciseSettingRowView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/31/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ExerciseSettingRowView<Destination: View>: View {

    // MARK: - Properties

    let title: String
    let description: String
    @Binding var selection: String
    @ViewBuilder let destination: Destination

    // MARK: - UI

    var body: some View {
        NavigationLink(
            destination: self.destination,
            label: {
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text(self.title)
                            .font(.headline)
                        Spacer()
                        Text(self.selection)
                            .font(.headline)
                    }
                    Text(self.description)
                        .font(.body)
                }
            })
    }
}
