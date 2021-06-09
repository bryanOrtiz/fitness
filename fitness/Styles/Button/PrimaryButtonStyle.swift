//
//  PrimaryButtonStyle.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/22/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(isEnabled ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2))
        }
}
