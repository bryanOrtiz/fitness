//
//  ActivityFactorView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/23/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

enum ActivityFactor: String, CaseIterable, Identifiable {
    case sedentary
    case light
    case moderate
    case high
    case extraHigh
    
    var id: String { "\(self.rawValue)" }
    
    var factorValue: Double {
        switch self {
        case .sedentary:
            return 1.2
        case .light:
            return 1.375
        case .moderate:
            return 1.55
        case .high:
            return 1.725
        case .extraHigh:
            return 1.9
        }
    }
    
    var title: String {
        switch self {
        case .sedentary:
            return "Sedentary"
        case .light:
            return "Light"
        case .moderate:
            return "Moderate"
        case .high:
            return "High"
        case .extraHigh:
            return "Extra High"
        }
    }
    
    var detail: String {
        switch self {
        case .sedentary:
            return "little or no exercise"
        case .light:
            return "light exercise/sports 1-3 days/week"
        case .moderate:
            return "moderate exercise/sports 3-5 days/week"
        case .high:
            return "hard exercise/sports 6-7 days a week"
        case .extraHigh:
            return "very hard exercise/sports & a physical job"
        }
    }
    
}

struct ActivityFactorView: View {
    
    // MARK: - Properties
    let didSelectActivityFactor: (_ factor: ActivityFactor) -> Void
    @State private var afExpanded = false
    
    @State private var sedantaryIsActive = true
    @State private var lightIsActive = false
    @State private var moderateIsActive = false
    @State private var highIsActive = false
    @State private var extraHighIsActive = false
    
    // MARK: - UI
    
    func bindingGetter(factor: ActivityFactor) -> Bool {
        switch factor {
        case .sedentary:
            return sedantaryIsActive
        case .light:
            return lightIsActive
        case .moderate:
            return moderateIsActive
        case .high:
            return highIsActive
        case .extraHigh:
            return extraHighIsActive
        }
    }
    
    func bindingSetter(factor: ActivityFactor,
                       isOn: Bool) {
        if isOn {
            didSelectActivityFactor(factor)
        }
        switch factor {
        case .sedentary:
            sedantaryIsActive = isOn
            guard isOn else { return }
            lightIsActive = false
            moderateIsActive = false
            highIsActive = false
            extraHighIsActive = false
        case .light:
            lightIsActive = isOn
            guard isOn else { return }
            sedantaryIsActive = false
            moderateIsActive = false
            highIsActive = false
            extraHighIsActive = false
        case .moderate:
            moderateIsActive = isOn
            guard isOn else { return }
            lightIsActive = false
            sedantaryIsActive = false
            highIsActive = false
            extraHighIsActive = false
        case .high:
            highIsActive = isOn
            guard isOn else { return }
            lightIsActive = false
            moderateIsActive = false
            sedantaryIsActive = false
            extraHighIsActive = false
        case .extraHigh:
            extraHighIsActive = isOn
            guard isOn else { return }
            lightIsActive = false
            moderateIsActive = false
            highIsActive = false
            sedantaryIsActive = false
        }
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: $afExpanded) {
            LazyVStack(alignment: .leading) {
                ForEach(ActivityFactor.allCases) { factor in
                    let binding = Binding<Bool> {
                        return bindingGetter(factor: factor)
                    } set: { isOn in
                        bindingSetter(factor: factor, isOn: isOn)
                    }
                    ActivityFactorItemView(factor: factor, isSelected: binding)
                }
            }
        } label: {
            Text("Activity Factor")
                .font(.title)
        }
    }
}

struct ActivityFactorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityFactorView(didSelectActivityFactor: { _ in })
    }
}
