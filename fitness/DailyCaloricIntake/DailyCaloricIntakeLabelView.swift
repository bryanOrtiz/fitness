//
//  DailyCaloricIntakeLabelView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/25/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct DailyCaloricIntakeLabelView: View {

    // MARK: - Properties

    let title: String
    let description: String
    let valueTitle: String
    let valueText: String

    // MARK: - UI

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
            Text(description)
                .font(.subheadline)
            HStack {
                Text(valueTitle)
                    .font(.headline)
                Spacer()
                Text(valueText)
                    .font(.headline)
            }
        }
    }
}
