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
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Choose a Class")
                            .font(.largeTitle)
                        .fontWeight(.semibold)
                        Spacer()

                    }
                    .padding(.horizontal)
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(CharacterData.characterClasses, id: \.name) { characterClass in
                                NavigationLink(destination: TalentsTreeView(characterClass: characterClass)) {
                                    HStack {
                                        Image(characterClass.iconName)
                                        Text(characterClass.name)
                                            .foregroundColor(characterClass.nameColor)
                                            .font(.title)
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.thinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: Color(characterClass.nameColor).opacity(1), radius: 5, x: 0, y: -1)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
            }
            
        }
    }
}

#Preview {
    ClassesListView()
}
