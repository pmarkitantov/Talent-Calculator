//
//  TabbarButtonView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 28/03/2024.
//

import SwiftUI

struct TabbarButtonView: View {
    let talentTrees: [TalentTree]
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 50) {
            ForEach(Array(talentTrees.enumerated()), id: \.element.name) { index, tree in
                Button(action: {
                    self.selectedTab = index
                }) {
                    VStack {
                        Image(tree.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(self.selectedTab == index ? Color.yellow : Color.clear, lineWidth: 3)
                            )
                        Text(tree.name)
                    }
                    .foregroundColor(self.selectedTab == index ? .yellow : .gray)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

#Preview {
    TabbarButtonView(talentTrees: [TalentTree(name: "Balance", background: "druidBalance", icon: "druid-balance-icon"),
                                   TalentTree(name: "Feral", background: "druidFeral", icon: "druid-feral-icon"),
                                   TalentTree(name: "Restoration", background: "druidRestoration", icon: "druid-restoration-icon")], selectedTab: .constant(0))
}
