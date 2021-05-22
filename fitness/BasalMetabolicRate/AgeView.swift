//
//  AgeView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/22/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct AgeView: View {

    // MARK: - Properties
    let ageCalculated: (_ age: Double) -> Void

    @State private var age = ""

    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading) {
            Text("Age")
                .font(.callout)
            TextField("0",
                      text: $age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .onChange(of: age, perform: { value in
                    guard let ageDouble = Double(value) else { return }
                    ageCalculated(ageDouble)
                })
        }
    }
}

struct AgeView_Previews: PreviewProvider {
    static var previews: some View {
        AgeView(ageCalculated: { _ in })
    }
}
