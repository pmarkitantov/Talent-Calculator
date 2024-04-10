//
//  GridView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI

import SwiftUI

struct TalentGridView: View {
    @ObservedObject var viewModel: GridViewModel
    @Binding var pointsSpend: Int
    private let rows = 7
    private let columns = 4
    var selectedBranchIndex: Int

    private var gridLayout: [GridItem] {
        Array(repeating: .init(.flexible()), count: columns)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 20) {
                ForEach(0 ..< rows * columns, id: \.self) { index in
                    // Расчет соответствующей строки и столбца для текущего индекса
                    let row = index / columns
                    let column = index % columns
                    if let talent = viewModel.talentsBranches[selectedBranchIndex].first(where: { $0.row  == row + 1 && $0.column  == column + 1 }) {
                        // Если талант найден, отображаем его иконку
                        TalentCell(talent: talent, pointsSpend: $pointsSpend, incrementCount: { talentId in
                            viewModel.incrementCount(for: talentId, inBranch: selectedBranchIndex)
                        })
                    } else {
                        // Если талант не найден, отображаем пустое пространство
                        Color.clear
                    }
                }
            }
        }
    }
}

#Preview {
    TalentGridView(viewModel: GridViewModel(chatacterClass: CharacterClass(name: "Druid", iconName: "druid", nameColor: .orange, talentTrees: [
        TalentTree(name: "Balance", background: "druidBalance", icon: "druid-balance-icon"),
        TalentTree(name: "Feral", background: "druidFeral", icon: "druid-feral-icon"),
        TalentTree(name: "Restoration", background: "druidRestoration", icon: "druid-restoration-icon")
    ])), pointsSpend: .constant(0), selectedBranchIndex: 1)
}
