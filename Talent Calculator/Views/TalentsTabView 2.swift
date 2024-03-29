//
//  TalentsTabView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI



struct TalentsTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            // Кнопки для переключения
            HStack {
                Button("Баланс") {
                    self.selectedTab = 0
                }
                .buttonStyle(TabButtonStyle(isSelected: selectedTab == 0))
                
                Button("Ферал") {
                    self.selectedTab = 1
                }
                .buttonStyle(TabButtonStyle(isSelected: selectedTab == 1))
                
                Button("Рестор") {
                    self.selectedTab = 2
                }
                .buttonStyle(TabButtonStyle(isSelected: selectedTab == 2))
            }
            Spacer()
            
            // Контент в зависимости от выбранной вкладки
            if selectedTab == 0 {
//                BalanceView()
            } else if selectedTab == 1 {
//                FeralView()
            } else if selectedTab == 2 {
//                RestorationView()
            }
        }
    }
}




#Preview {
    TalentsTabView()
}
