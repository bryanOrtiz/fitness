//
//  ImageURLView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/19/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI
import Combine

struct ImageURLView<Placeholder: View>: View {

    // MARK: - Properties
    let placeholder: () -> Placeholder
    let imgClosure: (_ loadedImage: Image) -> Image

    // MARK: - Bindings
    @ObservedObject var viewModel: ImageViewModel

    @State var image: UIImage? {
        didSet { debugPrint("somethign happened") }
    }
    var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Network
    let net: NetImage = Net()

    init(urlString: String,
         placeholder: @escaping () -> Placeholder,
         imgClosure: @escaping (_ loadedImage: Image) -> Image) {
        self.placeholder = placeholder
        self.imgClosure = imgClosure

        self.viewModel = ImageViewModel(imgURLString: urlString)
    }

    // MARK: - UI

    var body: some View {
        Group {
            if let uiImage = self.viewModel.uiImage {
                imgClosure(Image(uiImage: uiImage))
            } else {
                placeholder()
            }
        }

    }
}

struct ImageURLView_Previews: PreviewProvider {
    static var previews: some View {
        ImageURLView(urlString: "",
                     placeholder: { Text("loading") },
                     imgClosure: { image in
                        return image
                     })
    }
}
