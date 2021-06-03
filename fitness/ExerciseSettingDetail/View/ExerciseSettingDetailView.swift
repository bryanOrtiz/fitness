//
//  ExerciseSettingDetailView.swift
//  fitness
//
//  Created by Bryan Ortiz on 6/2/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ExerciseSettingDetailView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: ExerciseSettingDetailViewModel

    // MARK: - UI

    var body: some View {
        VStack {
            Divider()
            HStack {
                Button("edit", action: edit)
                    .buttonStyle(PrimaryButtonStyle())
                Button("Delete", action: delete)
                    .buttonStyle(DeleteButtonStyle())
            }
        }
    }

    // MARK: - Actions
    func delete() {
        self.viewModel.deleteWorkoutSetting()
    }

    func edit() {
        self.viewModel.editWorkoutSetting()
    }
}

// struct ExerciseSettingDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseSettingDetailView()
//    }
// }
