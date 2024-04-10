//
//  GridView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI

import SwiftUI

struct TalentGridView: View {
    @EnvironmentObject var viewModel: GridViewModel
    @Binding var pointsSpend: Int
    private let rows = 7
    private let columns = 4

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

                    if let talent = viewModel.talents.first(where: { $0.row == row + 1 && $0.column == column + 1 }) {
                        TalentCell(talent: talent, pointsSpend: $pointsSpend, incrementCount: viewModel.incrementCount)
                    } else {
                        // Если элемент не найден, оставляем ячейку пустой
                        Color.clear
                    }
                }
            }
        }
    }
}

#Preview {
    TalentGridView(pointsSpend: .constant(0))
        .environmentObject(GridViewModel(talentTreeName: "testDruidBalance"))
}
