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

    @ObservedObject var licenseViewModel = LicenseViewModel()
    @ObservedObject var languagesViewModel = LanguagesViewModel()
    @ObservedObject var daysOfTheWeekViewModel = DaysOfTheWeekViewModel()

    var body: some View {
        NavigationView {
            List {
                Button(action: licenseViewModel.getLicense) {
                    Text("Licenses")
                }
                Button(action: languagesViewModel.getLanguages) {
                    Text("Languages")
                }
                Button(action: daysOfTheWeekViewModel.getDaysOfTheWeek) {
                    Text("DaysOfTheWeek")
                }
            }
            .navigationBarTitle("Network Calls")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
