//
//  TalentsTreeView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI

struct TalentsTreeView: View {
    let characterClass: CharacterClass
    @ObservedObject var viewModel: GridViewModel
    @State private var selectedTab: Int  = 0
    @State private var currentLevel: Int = 10
    @State var pointsSpent: Int = 0

    init(characterClass: CharacterClass) {
        self.characterClass = characterClass

        self._viewModel = ObservedObject(initialValue: GridViewModel(chatacterClass: characterClass))
    }

    var pointsLeft: Int {
        51 - pointsSpent
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Фоновое изображение для текущего выбранного талантового дерева
                if let tree = characterClass.talentTrees.indices.contains(selectedTab) ? characterClass.talentTrees[selectedTab] : nil {
                    Image(tree.background)
                        .resizable()
                        .ignoresSafeArea()

                    VStack(spacing: 15) {
                        TalentTreeHeader(branchName: tree.name, currentLevel: $currentLevel, pointsSpent: $pointsSpent)
                        TalentGridView(viewModel: viewModel, pointsSpend: $pointsSpent, selectedBranchIndex: selectedTab)
                            .padding()

                        Rectangle()
                            .fill(Color.gray) // Задаём цвет перегородки
                            .frame(height: 2) // Задаём толщину перегородки равной 2
                            .edgesIgnoringSafeArea(.horizontal)

                        TabbarButtonView(talentTrees: characterClass.talentTrees, selectedTab: $selectedTab)
                    }
                } else {
                    Text("Выбранная вкладка недоступна")
                        .ignoresSafeArea()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TalentsTreeView(characterClass: CharacterClass(name: "Druid", iconName: "druid", nameColor: .orange, talentTrees: [
        TalentTree(name: "Balance", background: "druidBalance", icon: "druid-balance-icon"),
        TalentTree(name: "Feral", background: "druidFeral", icon: "druid-feral-icon"),
        TalentTree(name: "Restoration", background: "druidRestoration", icon: "druid-restoration-icon")
    ]))
    
}
