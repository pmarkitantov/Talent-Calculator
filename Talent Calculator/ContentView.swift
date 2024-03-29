//
//  ContentView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 1
    
    var body: some View {
        VStack {
            // Текущее выбранное представление
            switch selectedTab {
            case 1:
                Text("Первое представление")
            case 2:
                Text("Второе представление")
            case 3:
                Text("Третье представление")
            default:
                Text("Первое представление")
            }
            
            Spacer()
            
            // Кастомный TabBar
            HStack {
                // Кнопка для первого представления
                Button(action: {
                    self.selectedTab = 1
                }) {
                    Image(systemName: "1.circle")
                        .font(.largeTitle)
                        .foregroundColor(selectedTab == 1 ? .blue : .gray)
                }
                
                Spacer()
                
                // Кнопка для второго представления
                Button(action: {
                    self.selectedTab = 2
                }) {
                    Image(systemName: "2.circle")
                        .font(.largeTitle)
                        .foregroundColor(selectedTab == 2 ? .blue : .gray)
                }
                
                Spacer()
                
                // Кнопка для третьего представления
                Button(action: {
                    self.selectedTab = 3
                }) {
                    Image(systemName: "3.circle")
                        .font(.largeTitle)
                        .foregroundColor(selectedTab == 3 ? .blue : .gray)
                }
            }
            .padding()
            .background(Color(.systemBackground)) // Используйте .systemBackground для автоматической поддержки темной и светлой темы
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
