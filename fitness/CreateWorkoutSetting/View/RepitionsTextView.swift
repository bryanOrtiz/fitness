//
//  RepitionsTextView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/2/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct RepitionsTextView: View {

    // MARK: - Properties

    let title: String
    let placeholderText: String
    @Binding var text: String

    // MARK: - UI

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .font(.subheadline)
            TextField(self.placeholderText,
                      text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
