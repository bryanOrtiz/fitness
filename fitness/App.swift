//
//  App.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/15/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI
import Combine

struct App: View {

    @StateObject private var net = Net()
    @StateObject private var keychainService = KeychainService()

    private var cancellableSet: Set<AnyCancellable> = []

    var body: some View {
        NavigationView {
            if net.interceptor != nil {
                TabView {
                    ExerciseListView().tabItem { Text("Exercises") }
                    WorkoutsView().tabItem { Text("Workouts") }
                    NutritionPlansListView().tabItem { Text("Nutrition") }
                }
            } else {
                LoginView()
            }
        }.environmentObject(net)
        .onAppear(perform: {
            net.$credential
                .compactMap({ $0 })
                .flatMap { credential in
                    return keychainService.storeGenericPasswordFor(account: "",
                                                                   service: "",
                                                                   password: credential.accessToken)
                }
                .sink { _ in
                    debugPrint("error: error")
                } receiveValue: { _ in
                    debugPrint("it worked???")
                }
                .store(in: &cancellableSet)

//                .compactMap { credential -> AnyPublisher<Void, KeychainWrapperError>? in
//                    guard let credential = credential else { return nil }
//                    return keychainService.storeGenericPasswordFor(account: <#T##String#>,
//                                                                   service: <#T##String#>,
//                                                                   password: <#T##String#>)
//                }

        })
    }

    // MARK: - Actions
    func storeToken() {

    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        App()
    }
}
