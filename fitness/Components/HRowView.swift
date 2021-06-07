//
//  HRowView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/7/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct HRowView: View {

    // MARK: - Properties
    let title: String
    let detail: String

    // MARK: - Initializers

    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }

    // MARK: - UI

    var body: some View {
        HStack {
            Text(title).font(.headline)
            Spacer()
            Text(detail).font(.subheadline)
        }
    }
}

struct HRowView_Previews: PreviewProvider {
    static var previews: some View {
        HRowView(title: "title", detail: "detail")
    }
}
