//
//  ClassesListView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import SwiftUI

struct ClassesListView: View {
    @ObservedObject var viewModel = CharacterClassesViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.characterClasses) { characterClass in
                NavigationLink(destination: {
                    
                }, label: {
                    Image(characterClass.icon)
                    Text(characterClass.name)
                        .font(.title)
                })
            }
            .navigationTitle("Выбор класса")
        }
    }
}

#Preview {
    ClassesListView()
}
