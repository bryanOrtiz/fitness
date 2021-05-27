//
//  ProfileView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/27/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject private var deps: AppDeps

    // MARK: - UI

    var body: some View {
        Button("Log Out", action: logOut)
            .buttonStyle(SecondaryButtonStyle())
    }

    // MARK: - Actions
    func logOut() {
        deps.logOut()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
