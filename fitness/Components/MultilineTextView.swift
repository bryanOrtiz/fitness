//
//  MultilineTextView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct MultilineTextView: View {

    @Binding var description: String

    var body: some View {
        TextEditor(text: $description)
            .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1))
    }
}
