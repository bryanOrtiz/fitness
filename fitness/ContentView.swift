//
//  ContentView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/2/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button(action: doSomething) {
                Text("Click Me")
            }
        }
    }
    
    private let doSomething: () -> Void = {
        
        return
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
