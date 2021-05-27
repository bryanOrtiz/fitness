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
    @StateObject private var viewModel = ProfileViewModel()

    // MARK: - UI

    var body: some View {
        ScrollView {
            LazyVStack {
                Text("UserId: \(viewModel.profile?.user ?? 0)")
                Button("Log Out", action: logOut)
                    .buttonStyle(SecondaryButtonStyle())
            }
        }
        .navigationBarTitle("Profile")
        .onAppear {
            viewModel.net = deps.net
            viewModel.getProfile()
        }
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
