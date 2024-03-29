//
//  CharacterClasses.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 29/03/2024.
//

import Foundation
import SwiftUI

struct CharacterClass {
    let name: String
    let iconName: String
    let nameColor: Color
    let talentTrees: [TalentTree]
}

enum CharacterData {
    static let characterClasses: [CharacterClass] = [
        CharacterClass(name: "Druid", iconName: "druid", nameColor: .orange, talentTrees: [
            TalentTree(name: "Balance", background: "druidBalance", icon: "druid-balance-icon"),
            TalentTree(name: "Feral", background: "druidFeral", icon: "druid-feral-icon"),
            TalentTree(name: "Restoration", background: "druidRestoration", icon: "druid-restoration-icon")
        ]),
        CharacterClass(name: "Hunter", iconName: "hunter", nameColor: .green, talentTrees: [
            TalentTree(name: "Beast Mastery", background: "hunterBeastMastery", icon: "hunter-beast-mastery-icon"),
            TalentTree(name: "Marksmanship", background: "hunterMarksmanship", icon: "hunter-marksmanship-icon"),
            TalentTree(name: "Survival", background: "hunterSurvival", icon: "hunter-survival-icon")
        ]),
        CharacterClass(name: "Mage", iconName: "mage", nameColor: .cyan, talentTrees: [
            TalentTree(name: "Arcane", background: "mageArcane", icon: "mage-arcane-icon"),
            TalentTree(name: "Fire", background: "mageFire", icon: "mage-fire-icon"),
            TalentTree(name: "Frost", background: "mageFrost", icon: "mage-frost-icon")
        ]),
        CharacterClass(name: "Paladin", iconName: "paladin", nameColor: .pink, talentTrees: [
            TalentTree(name: "Holy", background: "paladinHoly", icon: "paladin-holy-icon"),
            TalentTree(name: "Protection", background: "paladinProtection", icon: "paladin-protection-icon"),
            TalentTree(name: "Retribution", background: "paladinRetribution", icon: "paladin-retribution-icon")
        ]),
        CharacterClass(name: "Priest", iconName: "priest", nameColor: .gray, talentTrees: [
            TalentTree(name: "Discipline", background: "priestDiscipline", icon: "priest-discipline-icon"),
            TalentTree(name: "Holy", background: "priestHoly", icon: "priest-holy-icon"),
            TalentTree(name: "Shadow", background: "priestShadow", icon: "priest-shadow-icon")
        ]),
        CharacterClass(name: "Rogue", iconName: "rogue", nameColor: .yellow, talentTrees: [
            TalentTree(name: "Assassination", background: "rogueAssassination", icon: "rogue-assassination-icon"),
            TalentTree(name: "Combat", background: "rogueCombat", icon: "rogue-combat-icon"),
            TalentTree(name: "Subtlety", background: "rogueSubtlety", icon: "rogue-subtlety-icon")
        ]),
        CharacterClass(name: "Shaman", iconName: "shaman", nameColor: .blue, talentTrees: [
            TalentTree(name: "Elemental", background: "shamanElemental", icon: "shaman-elemental-icon"),
            TalentTree(name: "Enhancement", background: "shamanEnhancement", icon: "shaman-enhancement-icon"),
            TalentTree(name: "Restoration", background: "shamanRestoration", icon: "shaman-restoration-icon")
        ]),
        CharacterClass(name: "Warlock", iconName: "warlock", nameColor: .purple, talentTrees: [
            TalentTree(name: "Affliction", background: "warlockAffliction", icon: "warlock-affliction-icon"),
            TalentTree(name: "Demonology", background: "warlockDemonology", icon: "warlock-demonology-icon"),
            TalentTree(name: "Destruction", background: "warlockDestruction", icon: "warlock-destruction-icon")
        ]),
        CharacterClass(name: "Warrior", iconName: "warrior", nameColor: .brown, talentTrees: [
            TalentTree(name: "Arms", background: "warriorArms", icon: "warrior-arms-icon"),
            TalentTree(name: "Fury", background: "warriorFury", icon: "warrior-fury-icon"),
            TalentTree(name: "Protection", background: "warriorProtection", icon: "warrior-protection-icon")
        ])
    ]
}
