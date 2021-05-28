//
//  MultiSelectButtonStyle.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/28/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct MultiSelectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(height: 44)
                .background(configuration.isPressed ? Color.white.opacity(0.4) : Color.clear)
                .foregroundColor(.black)
                .animation(.easeOut(duration: 0.2))
        }
}
