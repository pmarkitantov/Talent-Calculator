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
        VStack {
            HStack {
                Text(branchName)
                    .font(.headline)
                    .padding()
                Spacer()
                Text("Уровень: \(currentLevel)")
                    .padding()
                Spacer()
                Text("Очки: \(pointsSpent)")
                    .padding()
            }
            .background(Color.white.opacity(0.7))
            .cornerRadius(10)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    TalentTreeHeader(branchName: "Balance", currentLevel: .constant(10), pointsSpent: .constant(20))
}
