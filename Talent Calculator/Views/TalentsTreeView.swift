//
//  TalentsTreeView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI

struct TalentsTreeView: View {
    let characterClass: CharacterClass
    @State private var selectedTab: Int  = 0
    @State private var currentLevel: Int = 10
    @State private var pointsSpent: Int  = 0

    var body: some View {
        ZStack {
            // Фоновое изображение для текущего выбранного талантового дерева
            if let tree = characterClass.talentTrees.indices.contains(selectedTab) ? characterClass.talentTrees[selectedTab] : nil {
                Image(tree.background)
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 15) {
                    TalentTreeHeader(branchName: tree.name, currentLevel: $currentLevel, pointsSpent: $pointsSpent)
                    let talentTreeName = "\(characterClass.name.lowercased())\(tree.name)"
                    TestGridView()

                    Rectangle()
                        .fill(Color.gray) // Задаём цвет перегородки
                        .frame(height: 2) // Задаём толщину перегородки равной 2
                        .edgesIgnoringSafeArea(.horizontal)

                    // Кастомный TabBar для выбора талантового дерева
                    TabbarButtonView(talentTrees: characterClass.talentTrees, selectedTab: $selectedTab)
                }
            } else {
                Text("Выбранная вкладка недоступна")
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    TalentsTreeView(characterClass: CharacterClass(name: "Druid", iconName: "druid", nameColor: .orange, talentTrees: [
        TalentTree(name: "Balance", background: "druidBalance", icon: "druid-balance-icon"),
        TalentTree(name: "Feral", background: "druidFeral", icon: "druid-feral-icon"),
        TalentTree(name: "Restoration", background: "druidRestoration", icon: "druid-restoration-icon")
    ]))
    .environmentObject(GridViewModel(talentTreeName: "testDruidBalance"))
}
