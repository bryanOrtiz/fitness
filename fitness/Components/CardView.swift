//
//  CardView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct CardView: View {

    // MARK: - Properties
    let title: String
    let imgURLString: String

    // MARK: - UI
    var body: some View {
        VStack {
            Text(title)
                .padding(8)
            ImageURLView(urlString: imgURLString,
                         placeholder: { Text("loading") },
                         imgClosure: { image in
                            return image
                                .resizable()
                                .renderingMode(.template)
                         })
                .scaledToFit()
                .foregroundColor(.blue)
                .padding(8)
        }
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black, radius: 1, x: 0, y: 0))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Workout", imgURLString: "")
    }
}
