//
//  SecondaryButtonStyle.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/25/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(Color.clear)
                .foregroundColor(.blue)
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2))
        }
}
