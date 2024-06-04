//
//  TalentTreeHeader.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 29/03/2024.
//

import SwiftUI

struct TalentTreeHeader: View {
    var branchName: String
    @Binding var currentLevel: Int
    @Binding var pointsSpent: Int

    var body: some View {
        HStack {
            Text(branchName)
                .font(.headline)

            Spacer()
            Text("Уровень: \(currentLevel)")

            Spacer()
            Text("Очки: \(pointsSpent)")
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(10)
    }
}

#Preview {
    TalentTreeHeader(branchName: "Balance", currentLevel: .constant(10), pointsSpent: .constant(20))
}
