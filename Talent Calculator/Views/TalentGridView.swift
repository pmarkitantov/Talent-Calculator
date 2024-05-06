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

    private func talentFor(row: Int, column: Int) -> Talent? {
        viewModel.talentsBranches[selectedBranchIndex].first(where: { $0.row == row + 1 && $0.column == column + 1 })
    }

    func isTalentUnlocked(_ talent: Talent) -> Bool {
        guard let dependencyName = talent.dependencyName else { return talent.requiredPoints <= pointsSpend }

        let requiredTalent = viewModel.talentsBranches[selectedBranchIndex].first(where: { $0.name == dependencyName })
        return requiredTalent?.currentPoints == requiredTalent?.maxPoints && talent.requiredPoints <= pointsSpend
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 20) {
                ForEach(0 ..< rows * columns, id: \.self) { index in
                    let row = index / columns
                    let column = index % columns
                    if let talent = talentFor(row: row, column: column) {
                        let isUnlocked = isTalentUnlocked(talent)
                        GeometryReader { geometry in
                            TalentCell(talent: talent, pointsSpend: $pointsSpend, incrementCount: { talentId in
                                viewModel.incrementCount(for: talentId, inBranch: selectedBranchIndex)
                            })
                            .overlay {
                                if let arrow = talent.arrow {
                                    let cellWidth = geometry.size.width
                                    let cellHeight = geometry.size.height
                                    Image(arrow.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: frameWidth(for: arrow, cellWidth), height: frameHeight(for: arrow, cellHeight))
                                        .offset(x: xOffset(for: arrow, with: cellWidth), y: yOffset(for: arrow, with: cellHeight))
                                }
                            }
                        }
                        .frame(height: 75) // Пример высоты, настройте по необходимости
                        .allowsHitTesting(isUnlocked)
                        .grayscale(isUnlocked ? 0 : 1)
                    } else {
                        Color.clear
                    }
                }
            }
            .padding(.top, 5)
        }
    }

    func xOffset(for arrow: Arrow, with cellWidth: CGFloat) -> CGFloat {
        switch arrow.side {
        case "left":
            return -cellWidth / 2 // Пример смещения, настройте по необходимости
        case "right":
            return cellWidth / 4
        case "topLeft":
            return -cellWidth / 4 + 5
        default:
            return 0
        }
    }

    func yOffset(for arrow: Arrow, with cellHeight: CGFloat) -> CGFloat {
        switch (arrow.side, arrow.size) {
        case ("top", "short"):
            return -cellHeight / 2 - 5
        case ("top", "medium"):
            return -cellHeight - 20
        case ("topLeft", _):
            return -cellHeight
        case("top","long"):
            return -cellHeight * 2 + 10
        default:
            return 0
        }
    }

    func frameWidth(for arrow: Arrow, _ cellWidth: CGFloat) -> CGFloat {
        switch (arrow.side, arrow.size) {
        case("topLeft", "medium"):
            return cellWidth
        case ("left", _):
            return cellWidth / 2
        case (_, "short"):
            return cellWidth / 2
        case (_, "medium"), (_, "long"):
            return cellWidth
        default:
            return cellWidth / 2
        }
    }

    func frameHeight(for arrow: Arrow, _ cellHeight: CGFloat) -> CGFloat {
        switch (arrow.side, arrow.size) {
        case ("left", "short"):
            return cellHeight / 1.7
        case ("top", "medium"):
            return cellHeight + 50
        case("topLeft", "medium"):
            return cellHeight
        case("top","long"):
            return cellHeight * 3 - 5
        default:
            return cellHeight
        }
    }
}

#Preview {
    TalentGridView(viewModel: GridViewModel(chatacterClass: CharacterData.characterClasses[0]), pointsSpend: .constant(0), selectedBranchIndex: 2)
}
