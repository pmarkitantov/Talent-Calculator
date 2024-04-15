//
//  TalentCell.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 10/04/2024.
//

import SwiftUI

struct TalentCell: View {
    let talent: Talent
    @Binding var pointsSpend: Int
    let incrementCount: (UUID) -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Button(action: {
                incrementCount(talent.id)
                pointsSpend += 1
            }) {
                Image(talent.icon)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        pointsSpend >= talent.requiredPoints ?
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(talent.currentPoints >= talent.maxPoints ? Color.yellow : (talent.currentPoints >= 0 ? Color.green : Color.clear), lineWidth: 5) : nil
                    )
            }
            Text("\(talent.currentPoints)/\(talent.maxPoints)")
                .padding(5)
                .background(Color.black.opacity(0.7))
                .foregroundColor(talent.currentPoints >= talent.maxPoints ? Color.yellow : Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .offset(x: 10, y: 10)
                .zIndex(1)
        }
        .frame(width: 70, height: 70)
    }

    private var isConditionMet: Bool {
        pointsSpend >= talent.requiredPoints
    }
}

#Preview {
    TalentCell(talent: Talent(name: "Improved wrath", icon: "spell_nature_abolishmagic", baseDescription: "Description of Talent 1.", maxPoints: 5, requiredPoints: 0, row: 1, column: 1), pointsSpend: .constant(0)) { _ in
        // Заглушка для действия увеличения счетчика
    }

    .previewLayout(.sizeThatFits)
    .padding()
}
