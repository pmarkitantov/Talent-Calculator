//
//  AnotherTestView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 29/03/2024.
//

import SwiftUI

struct AnotherTestView: View {
    @ObservedObject var viewModel: GridViewModel
    @State var pointsSpend = 0

    // Определение структуры сетки
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    var body: some View {
        // Визуализация сетки
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0 ..< 28) { index in // Для 4 колонок * 7 строк = 28 ячеек
                    if index < viewModel.talents.count {
                        Image(viewModel.talents[index].icon)
                            .resizable()
                            .scaledToFit()

                    } else {
                        Color.clear // Пустая ячейка для сохранения структуры сетки
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    AnotherTestView(viewModel: GridViewModel(talentTreeName: "druidBalance"))
}
