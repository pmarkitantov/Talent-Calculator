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
    @State private var selectedTab: Int = 0

    init(characterClass: CharacterClass) {
        self.characterClass = characterClass

        self._viewModel = ObservedObject(initialValue: GridViewModel(characterClass: characterClass))
    }

    var body: some View {
        ZStack {
            if let tree = characterClass.talentTrees.indices.contains(selectedTab) ? characterClass.talentTrees[selectedTab] : nil {
                Image(tree.background)
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    header
                        .padding(.horizontal)

                    TalentGridView(viewModel: viewModel, selectedBranchIndex: selectedTab)
                        .padding(.horizontal)

                    Spacer()

                    TabbarButtonView(talentTrees: characterClass.talentTrees, selectedTab: $selectedTab)
                        .frame(height: 60)
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

extension TalentsTreeView {
    var header: some View {
        HStack {
            Text(characterClass.name)
                .foregroundStyle(Color(characterClass.nameColor))
            Text("(\(viewModel.branchPointAsString()))")

            Spacer()
            Text("Points left: \(viewModel.pointsLeft)")
        }
        .font(.headline)
        .fontWeight(.bold)
        .foregroundStyle(.accent)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.accent, lineWidth: 2)
        }
    }
}

#Preview {
    TalentsTreeView(characterClass: CharacterData.characterClasses[2])
}
