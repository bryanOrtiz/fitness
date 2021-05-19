//
//  CardView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI
import AlamofireImage

struct CardView: View {

    // MARK: - Properties
    let title: String

    @ObservedObject var viewModel: ImageViewModel

    private var imageView: SwiftUI.Image?

    // MARK: - Initializers
    init(title: String, imgURLString: String) {
        self.title = title
        self.viewModel = ImageViewModel(imgURLString: imgURLString)
    }

    // MARK: - UI
    var body: some View {
        VStack {
            Text(title)
            if let uiImage = self.viewModel.uiImage {
                Image(uiImage: uiImage)
            } else {
                Image(systemName: "person")
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Workout", imgURLString: "")
    }
}
