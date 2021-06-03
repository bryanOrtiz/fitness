//
//  RepititionsMenuView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/2/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct RepititionsMenuView<MenuItems: View>: View {

    // MARK: - Properties

    let title: String
    let placeholderText: String
    @Binding var text: String

    @ViewBuilder let items: MenuItems

    // MARK: - UI

    var body: some View {
        Menu {
            self.items
        } label: {
            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.subheadline)
                TextField(self.placeholderText,
                          text: self.$text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .foregroundColor(.black)
    }
}
