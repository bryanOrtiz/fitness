//
//  DetailRowView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/16/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct DetailRowView: View {

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
            Text(title).font(.title)
            Text(detail).font(.body)
        }
    }
}

struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRowView(title: "Title", detail: "detail")
    }
}
