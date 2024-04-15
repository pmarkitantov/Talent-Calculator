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
                imageForTalent
            }
            .disabled(!isConditionMet)

            Text("\(talent.currentPoints)/\(talent.maxPoints)")
                .talentCounterStyle(isMaxedOut: talent.currentPoints >= talent.maxPoints)
                .grayscale(isConditionMet ? 0 : 1)
        }
//        .frame(width: 70, height: 70)
        .allowsHitTesting(talent.currentPoints < talent.maxPoints && isConditionMet)
    }

    private var isConditionMet: Bool {
        pointsSpend >= talent.requiredPoints
    }

    private var imageForTalent: some View {
        Image(talent.icon)
            .resizable()
//            .colorMultiply(isConditionMet ? Color.white : Color.gray)
            .grayscale(isConditionMet ? 0 : 1)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                isConditionMet ?
                    RoundedRectangle(cornerRadius: 10)
                    .stroke(talent.currentPoints >= talent.maxPoints ? Color.yellow : (talent.currentPoints > 0 ? Color.green : Color.clear), lineWidth: 5) :
                    nil
            )
    }
}

extension Text {
    func talentCounterStyle(isMaxedOut: Bool) -> some View {
        padding(5)
            .background(Color.black.opacity(0.7))
            .foregroundColor(isMaxedOut ? Color.yellow : Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .offset(x: 10, y: 10)
            .zIndex(1)
    }
}

#Preview {
    TalentCell(talent: Talent(name: "Improved wrath", icon: "spell_nature_abolishmagic", baseDescription: "Description of Talent 1.", maxPoints: 5, requiredPoints: 0, row: 1, column: 1), pointsSpend: .constant(0)) { _ in
        // Заглушка для действия увеличения счетчика
    }

    .previewLayout(.sizeThatFits)
    .padding()
}
