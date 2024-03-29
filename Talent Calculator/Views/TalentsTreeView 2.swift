//
//  TalentsTreeView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI


struct TalentsTreeView: View {
    let className: String
    
        
    var body: some View {
            if let branches = TalentBranches.branches[className] {
                if className == "druid"{
                    TalentGridView(viewModel: GridViewModel(talentTreeName: "\(className)\(branches[0])"), backgroundImage: "\(className)\(branches[0])")
                } else {
                    Text("Нет данных о ветках талантов для класса \(className)")
                }
            } else {
                Text("Нет информации о ветках талантов для класса \(className)")
            }
        }
}

#Preview {
    TalentsTreeView(className: "druid")
}
