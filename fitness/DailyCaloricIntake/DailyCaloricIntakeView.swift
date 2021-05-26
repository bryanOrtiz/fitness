//
//  DailyCaloricIntakeView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/25/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct DailyCaloricIntakeView: View {
    
    // MARK: - Properties
    
    @State private var bmr: Double = 0
    @State private var activityFactor: Double = 1.2
    @State private var total: Double = 0
    
    // MARK: - UI
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    BasalMetabolicRate(bmr: $bmr)
                    Divider()
                    ActivityFactorView(activityFactor: $activityFactor)
                    Spacer()
                }.padding(16)
            }
            VStack {
                Divider()
                HStack {
                    Text("Total: ")
                    Spacer()
                    Text("\(total)")
                        .font(.title)
                }
                Button("Calculate", action: calculate)
                    .buttonStyle(PrimaryButtonStyle())
            }.padding([.leading, .trailing, .bottom], 16)
        }
        .navigationTitle("Daily Caloric Intake")
    }
    
    // MARK: - Actions
    
    func calculate() {
        total = bmr * activityFactor
    }
}

struct DailyCaloricIntakeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyCaloricIntakeView()
    }
}
