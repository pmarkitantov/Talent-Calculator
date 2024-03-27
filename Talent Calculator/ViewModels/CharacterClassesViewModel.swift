//
//  CharacterClassesViewModel.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import UIKit

class CharacterClassesViewModel: ObservableObject {
    @Published var classes: [CharacterClass] = [
        CharacterClass(name: "Druid", icon: "druid"),
        CharacterClass(name: "Hunter", icon: "hunter"),
        CharacterClass(name: "Mage", icon: "mage"),
        CharacterClass(name: "Paladin", icon: "paladin"),
        CharacterClass(name: "Priest", icon: "priest"),
        CharacterClass(name: "Rogue", icon: "rogue"),
        CharacterClass(name: "Shaman", icon: "shaman"),
        CharacterClass(name: "Warlock", icon: "warlock"),
        CharacterClass(name: "Warrior", icon: "warrior")
    ]
}
