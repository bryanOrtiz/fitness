//
//  NetImage.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/18/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

protocol NetImage {
    func getImage(urlString: String) -> DataResponsePublisher<AlamofireImage.Image>
}

extension Net: NetImage {
    func getImage(urlString: String) -> DataResponsePublisher<AlamofireImage.Image> {
        return session.request(self.imgBaseURL + urlString)
            .validate()
            .publishResponse(using: ImageResponseSerializer())
    }
}
