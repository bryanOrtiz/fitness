//
//  IsRepeatingView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/31/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

enum SetsRepeating: String, CaseIterable, Identifiable {
    case repeating = "Yes"
    case custom = "No"

    var id: String { self.rawValue }
}

struct IsRepeatingView: View {

    @State private var selection = SetsRepeating.repeating

    var body: some View {
        HStack {
            Text("Are your sets the same?")
            Spacer()
            Picker("", selection: $selection) {
                ForEach(SetsRepeating.allCases, id: \.self) { repeating in
                    Text(repeating.rawValue)
                }

            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct IsRepeatingView_Previews: PreviewProvider {
    static var previews: some View {
        IsRepeatingView()
    }
}
