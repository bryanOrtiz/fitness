//
//  App.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/15/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct App: View {
    var body: some View {
        NavigationView {
            TabView {
                ExerciseCategories().tabItem { Text("Exercises") }
            }
        }
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        App()
    }
}
