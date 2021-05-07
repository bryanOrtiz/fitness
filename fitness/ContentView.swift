//
//  ContentView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/2/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI
import Alamofire
import Combine

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button(action: doSomething) {
                Text("Click Me")
            }
        }
    }
    
    private var disposables: Set<AnyCancellable> = []
    
    private let doSomething: () -> Void = {
        let net = Net1()
        net.getLanguages().responseDecodable(of: Page<Language>.self) { print($0) }
        
        
//        net.getUserProfileOldSchool()
        
//        net.getUserProfile().sink { error in
//            print(error)
//        } receiveValue: { profile in
//            print("Publisher Success: \(profile)")
//        }.store(in: &disposables)

//        let sub = net.getUserProfile()
//            .sink(receiveCompletion: { print ("completion: \($0)") },
//                      receiveValue: { print ("value: \($0)") })
//        sub.cancel()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
