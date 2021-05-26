//
//  App.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/15/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct App: View {

    @StateObject private var net = Net()

    var body: some View {
        if net.interceptor != nil {
            TabView {
                NavigationView {
                    ExerciseListView()
                }.tabItem { Text("Exercises") }
                NavigationView {
                    WorkoutsView()
                }.tabItem { Text("Workouts") }
                NavigationView {
                    NutritionPlansListView()
                }.tabItem { Text("Nutrition") }
            }
        } else {
            NavigationView {
                LoginView()
            }.environmentObject(net)
        }
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        App()
    }
}
