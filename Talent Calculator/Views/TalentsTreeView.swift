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
    @State var pointsSpent: Int = 0
    @State private var currentLevel: Int = 10

    init(characterClass: CharacterClass) {
        self.characterClass = characterClass

        self._viewModel = ObservedObject(initialValue: GridViewModel(chatacterClass: characterClass))
    }

    var body: some View {
        ZStack {
            // Фоновое изображение для текущего выбранного талантового дерева
            if let tree = characterClass.talentTrees.indices.contains(selectedTab) ? characterClass.talentTrees[selectedTab] : nil {
                Image(tree.background)
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    TalentGridView(viewModel: viewModel, pointsSpend: $pointsSpent, selectedBranchIndex: selectedTab)
                        .padding(.horizontal)
                        

                    RoundedRectangle(cornerRadius:10)
                        .fill(Color.yellow) // Задаём цвет перегородки
                        .frame(height: 5) // Задаём толщину перегородки равной 2

                    TabbarButtonView(talentTrees: characterClass.talentTrees, selectedTab: $selectedTab)
                        .padding()
                }
            } else {
                Text("Выбранная вкладка недоступна")
                    .ignoresSafeArea()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TalentsTreeView(characterClass: CharacterData.characterClasses[0])
}
