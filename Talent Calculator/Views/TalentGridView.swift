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
    @State var pointsSpend = 0

    func isConditionMet(pointsSpend: Int, requiredPoints: Int) -> Bool {
        return pointsSpend >= requiredPoints
    }

    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: viewModel.totalColumns)

        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.talents, id: \.id) { talent in
                    if talent.maxPoints > 0 {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                            Button(action: {
                                viewModel.incrementCount(for: talent.id)
                                pointsSpend += 1
                            }) {
                                Image(talent.icon)
                                    .colorMultiply(pointsSpend >= talent.requiredPoints ? Color.white : Color.gray)
                                    .overlay(
                                        pointsSpend >= talent.requiredPoints ?
                                            RoundedRectangle(cornerRadius: 10)
                                            .stroke(talent.currentPoints >= talent.maxPoints ? Color.yellow : (talent.currentPoints >= 0 ? Color.green : Color.clear), lineWidth: 3) :
                                            nil
                                    )
                            }
                            Text("\(talent.currentPoints)/\(talent.maxPoints)")
                                .padding(3)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(talent.currentPoints >= talent.maxPoints ? Color.yellow : (talent.currentPoints >= 0 ? Color.green : Color.clear))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .offset(x: 10, y: 10)
                                .zIndex(1)
                        }
                        .frame(width: 70, height: 70)
                        .allowsHitTesting(talent.currentPoints < talent.maxPoints && pointsSpend >= talent.requiredPoints)
                    } else {
                        // Пустое место для отсутствующих элементов
                        Text("")
                            .frame(width: 70, height: 70)
                            .background(Color.clear)
                            .cornerRadius(10)
                    }
                }
            }
        }

        .background(Color.clear)
    }
}

#Preview {
    TalentGridView(viewModel: GridViewModel(talentTreeName: "druidBalance"))
}
