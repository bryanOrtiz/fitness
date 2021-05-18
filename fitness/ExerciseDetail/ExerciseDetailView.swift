//
//  ExerciseDetailView.swift
//  fitness
//
//  Created by Bryan Ortiz on 5/16/21.
//  Copyright © 2021 Ortiz. All rights reserved.
//

import SwiftUI

struct ExerciseDetailView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: ExerciseDetailViewModel

    // MARK: - Initializers
    init(exercise: Exercise) {
        viewModel = ExerciseDetailViewModel(exercise: exercise)
    }

    // MARK: - UI
    var body: some View {
        GeometryReader { metrics in
            List {
                VStack(alignment: .center) {
                    Text("Image").frame(alignment: .center)
                }.frame(height: metrics.size.height * 0.3)
                DetailRowView(title: "Category", detail: viewModel.info.category.name)
                DetailRowView(title: "Equipment", detail: viewModel.info.equipment.reduce("", { "\($0), \($1.name)" }))
                DetailRowView(title: "Description", detail: viewModel.info.description)
                DetailRowView(title: "Muscles", detail: viewModel.info.muscles.reduce("", { "\($0), \($1.name)" }))
            }.navigationBarTitle(Text(viewModel.info.name)).background(Color.red)
        }
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
//        ExerciseDetailView(exercise: Exercise(id: 0,
//                                              name: <#T##String#>,
//                                              uuid: <#T##String#>,
//                                              description: <#T##String#>,
//                                              creationDate: <#T##String#>,
//                                              category: <#T##Int#>,
//                                              muscles: <#T##[Int]#>,
//                                              musclesSecondary: <#T##[Int]#>,
//                                              equipment: <#T##[Int]#>,
//                                              language: <#T##Int#>,
//                                              license: <#T##Int#>,
//                                              licenseAuthor: <#T##String#>,
//                                              variations: <#T##[Int]#>))
    }
}
