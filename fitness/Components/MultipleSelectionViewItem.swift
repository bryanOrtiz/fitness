//
//  MultipleSelectionViewItem.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct MultipleSelectionViewItem: View {

    // MARK: - Properties

    let title: String
    @Binding var isSelected: Bool

    // MARK: - UI

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                Spacer()
                Image(systemName: "checkmark")
                    .scaleEffect(self.isSelected ? 1 : 0)
                    .opacity(self.isSelected ? 1 : 0)
                    .animation(.spring())
            }
        }
        .buttonStyle(MultiSelectButtonStyle())
    }

    // MARK: - Actions
    func action() {
        isSelected.toggle()
    }
}
