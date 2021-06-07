//
//  FitnessEmptyView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct FitnessEmptyView: View {

    // MARK: - Properties

    @State var title: String
    @State var buttonText: String
    @State var buttonAction: () -> Void

    // MARK: - UI

    var body: some View {
        VStack {
            Spacer()
            Text(self.title)
                .font(.headline)
            Spacer()
            Button(self.buttonText, action: self.buttonAction)
                .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessEmptyView(title: "title", buttonText: "buttonText", buttonAction: { debugPrint("😀") })
    }
}
