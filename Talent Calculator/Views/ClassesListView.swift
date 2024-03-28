//
//  ClassesListView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import SwiftUI

struct ClassesListView: View {
    let characterClasses: [CharacterClass] = [
        CharacterClass(name: "Druid", iconName: "druid", nameColor: .orange),
        CharacterClass(name: "Hunter", iconName: "hunter", nameColor: .green),
        CharacterClass(name: "Mage", iconName: "mage", nameColor: .cyan),
        CharacterClass(name: "Paladin", iconName: "paladin", nameColor: .pink),
        CharacterClass(name: "Priest", iconName: "priest", nameColor: .gray),
        CharacterClass(name: "Rogue", iconName: "rogue", nameColor: .yellow),
        CharacterClass(name: "Shaman", iconName: "shaman", nameColor: .blue),
        CharacterClass(name: "Warlock", iconName: "warlock", nameColor: .purple),
        CharacterClass(name: "Warrior", iconName: "warrior", nameColor: .brown),
        
    ]
    
    var body: some View {
        NavigationView {
            List(characterClasses, id: \.name) { characterClass in
                NavigationLink(destination: TalentsTreeView(className: characterClass.name.lowercased())) {
                    HStack {
                        Image(characterClass.iconName) // Используй имя системной иконки или имя файла иконки
                        Text(characterClass.name)
                            .foregroundColor(characterClass.nameColor)
                            .font(.title)
                    }
                }
            }
            .navigationTitle("Select a Class")
        }
    }
}


#Preview {
    ClassesListView()
}
