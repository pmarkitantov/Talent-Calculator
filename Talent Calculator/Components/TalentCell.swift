//
//  TalentCell.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 10/04/2024.
//

import SwiftUI

struct TalentCell: View {
    let talent: Talent
    var isUnlocked: Bool

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(talent.icon)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    isUnlocked ?
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(talent.currentPoints >= talent.maxPoints ? Color.accentColor : (talent.currentPoints >= 0 ? Color.green : Color.clear), lineWidth: 5) : nil
                )
            Text("\(talent.currentPoints)/\(talent.maxPoints)")
                .padding(5)
                .background(Color.black.opacity(0.7))
                .foregroundColor(talent.currentPoints >= talent.maxPoints ? Color.accentColor : Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .offset(x: 10, y: 10)
                .zIndex(1)
        }
    }
}

#Preview {
    TalentCell(talent: Talent(name: "Improved wrath", icon: "spell_nature_abolishmagic", baseDescription: "Description of Talent 1.", maxPoints: 5, requiredPoints: 0, row: 1, column: 1), isUnlocked: true)
        .previewLayout(.sizeThatFits)
        .padding()
}
