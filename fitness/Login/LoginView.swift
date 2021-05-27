//
//  LoginView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/25/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct LoginView: View {

    // MARK: - Properties
    @EnvironmentObject private var deps: AppDeps
    @StateObject private var viewModel = LoginViewModel()

    @State private var email = ""
    @State private var password = ""

    // MARK: - UI

    var body: some View {
        LazyVStack(spacing: 8) {
            Spacer()
            TextField("johnappleseed@email.com", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            SecureField("password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Login") {
                loginAction()
            }.buttonStyle(PrimaryButtonStyle())
            Button("Sign Up") {
                debugPrint("signing up")
            }.buttonStyle(SecondaryButtonStyle())
            Spacer()
        }.padding([.leading, .trailing], 16)
        .onAppear(perform: {
            viewModel.net = deps.net
        })
    }

    // MARK: - Actions
    func loginAction() {
        viewModel.login(username: email, password: password)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
