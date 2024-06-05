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
    private let rows = 7
    private let columns = 4
    var selectedBranchIndex: Int = 0
    var selectedBranch: TalentBranch {
        return viewModel.talentsBranches[selectedBranchIndex]
    }

    private var gridLayout: [GridItem] {
        Array(repeating: .init(.flexible()), count: columns)
    }

    private func talentFor(row: Int, column: Int) -> Talent? {
        selectedBranch.talents?.first(where: { $0.row == row + 1 && $0.column == column + 1 })
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 20) {
                ForEach(0 ..< rows * columns, id: \.self) { index in
                    let row = index / columns
                    let column = index % columns
                    if let talent = talentFor(row: row, column: column) {
                        let isUnlocked = viewModel.isTalentActive(talent: talent, branchIndex: selectedBranchIndex)
                        GeometryReader { geometry in
                            ZStack {
                                Button {
                                    viewModel.incrementCount(for: talent.id, inBranch: selectedBranchIndex)
                                } label: {
                                    TalentCell(talent: talent, isUnlocked: isUnlocked)
                                }

                                .overlay {
                                    if let arrow = talent.arrow {
                                        let cellWidth = geometry.size.width
                                        let cellHeight = geometry.size.height
                                        Image(arrow.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: ArrowCalculations.frameWidth(for: arrow, cellWidth), height: ArrowCalculations.frameHeight(for: arrow, cellHeight))
                                            .offset(x: ArrowCalculations.xOffset(for: arrow, with: cellWidth), y: ArrowCalculations.yOffset(for: arrow, with: cellHeight))
                                    }
                                }
                            }
                        }
                        .frame(height: 75)
                        .allowsHitTesting(isUnlocked)
                        .grayscale(isUnlocked || talent.currentPoints != 0 ? 0 : 1)
                    } else {
                        Color.clear
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    TalentGridView(viewModel: GridViewModel(characterClass: CharacterData.characterClasses[0]), selectedBranchIndex: 1)
}
