//
//  ActivityFactorItemView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/23/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ActivityFactorItemView: View {

    // MARK: - Properties
    let factor: ActivityFactor
    @Binding var isSelected: Bool

    // MARK: - UI
    var body: some View {
        Toggle(isOn: $isSelected) {
            VStack(alignment: .leading) {
                Text(factor.title)
                    .font(.headline)
                Text(factor.detail)
                    .font(.subheadline)
            }
        }
    }
}

struct ActivityFactorItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityFactorItemView(factor: ActivityFactor.sedentary,
                               isSelected: Binding<Bool>(get: { true }, set: { _ in }))
    }
}
