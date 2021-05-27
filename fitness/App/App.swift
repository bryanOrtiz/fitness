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

    @StateObject private var deps = AppDeps()

    private var cancellableSet: Set<AnyCancellable> = []

    var body: some View {
        NavigationView {
            if deps.isLoggedIn {
                TabView {
                    ExerciseListView().tabItem { Text("Exercises") }
                    WorkoutsView().tabItem { Text("Workouts") }
                    NutritionPlansListView().tabItem { Text("Nutrition") }
                    ProfileView().tabItem { Text("Profile") }
                }
            } else {
                LoginView()
            }
        }.environmentObject(deps)
        .onAppear(perform: {
            deps.getCredentials()
            deps.storeCredentials()
            deps.observeLoginState()
        })
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        App()
    }
}
