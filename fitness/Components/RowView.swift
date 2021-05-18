//
//  RowView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/17/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct RowView: View {
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
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            Text(detail).font(.subheadline)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(title: "title", detail: "detail")
    }
}
