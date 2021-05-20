//
//  ImageViewModel.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Combine
import AlamofireImage

class ImageViewModel: ObservableObject {

    // MARK: - Properties
    @Published var uiImage: AlamofireImage.Image?

    private var cancellableSet: Set<AnyCancellable> = []

    private let net: NetImage = Net()

    // MARK: - Initializers
    init(imgURLString: String) {
        getImage(urlString: imgURLString)
    }

    // MARK: - Network

    private func getImage(urlString: String) {
        net.getImage(urlString: urlString)
            .result()
            .map { result in
                switch result {
                case let .success(image):
                    return image
                case let .failure(error):
                    debugPrint("error: \(error)")
                    return nil
                }
            }
            .assign(to: \.uiImage, on: self)
            .store(in: &cancellableSet)
    }
}
