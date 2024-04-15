//
//  ClassesListView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import SwiftUI

struct ClassesListView: View {
    var body: some View {
        NavigationStack {
            List(CharacterData.characterClasses, id: \.name) { characterClass in
                NavigationLink(destination: TalentsTreeView(characterClass: characterClass)) {
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
