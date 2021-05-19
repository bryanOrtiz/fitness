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

    @Published var uiImage: AlamofireImage.Image?

    private var cancellableSet: Set<AnyCancellable> = []

    let net: NetImage = Net()

    init(imgURLString: String) {
        getImage(urlString: imgURLString)
    }

    func getImage(urlString: String) {
        net.getImage(urlString: urlString)
            .result()
            .map { result in
                switch result {
                case let .success(image):
                    debugPrint(image)
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
