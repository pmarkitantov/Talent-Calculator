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
    var talentsBranches: [TalentBranch]
}

enum CharacterData {
    static let characterClasses: [CharacterClass] = [
        CharacterClass(name: "Druid", iconName: "druid", nameColor: .orange, talentsBranches: [
            TalentBranch(name: "Balance", background: "druidBalance", icon: "druid-balance-icon"),
            TalentBranch(name: "Feral", background: "druidFeral", icon: "druid-feral-icon"),
            TalentBranch(name: "Restoration", background: "druidRestoration", icon: "druid-restoration-icon")
        ]),
        CharacterClass(name: "Hunter", iconName: "hunter", nameColor: .green, talentsBranches: [
            TalentBranch(name: "Beast Mastery", background: "hunterBeastMastery", icon: "hunter-beast-mastery-icon"),
            TalentBranch(name: "Marksmanship", background: "hunterMarksmanship", icon: "hunter-marksmanship-icon"),
            TalentBranch(name: "Survival", background: "hunterSurvival", icon: "hunter-survival-icon")
        ]),
        CharacterClass(name: "Mage", iconName: "mage", nameColor: .cyan, talentsBranches: [
            TalentBranch(name: "Arcane", background: "mageArcane", icon: "mage-arcane-icon"),
            TalentBranch(name: "Fire", background: "mageFire", icon: "mage-fire-icon"),
            TalentBranch(name: "Frost", background: "mageFrost", icon: "mage-frost-icon")
        ]),
        CharacterClass(name: "Paladin", iconName: "paladin", nameColor: .paladin, talentsBranches: [
            TalentBranch(name: "Holy", background: "paladinHoly", icon: "paladin-holy-icon"),
            TalentBranch(name: "Protection", background: "paladinProtection", icon: "paladin-protection-icon"),
            TalentBranch(name: "Retribution", background: "paladinRetribution", icon: "paladin-retribution-icon")
        ]),
        CharacterClass(name: "Priest", iconName: "priest", nameColor: .white, talentsBranches: [
            TalentBranch(name: "Discipline", background: "priestDiscipline", icon: "priest-discipline-icon"),
            TalentBranch(name: "Holy", background: "priestHoly", icon: "priest-holy-icon"),
            TalentBranch(name: "Shadow", background: "priestShadow", icon: "priest-shadow-icon")
        ]),
        CharacterClass(name: "Rogue", iconName: "rogue", nameColor: .yellow, talentsBranches: [
            TalentBranch(name: "Assassination", background: "rogueAssassination", icon: "rogue-assassination-icon"),
            TalentBranch(name: "Combat", background: "rogueCombat", icon: "rogue-combat-icon"),
            TalentBranch(name: "Subtlety", background: "rogueSubtlety", icon: "rogue-subtlety-icon")
        ]),
        CharacterClass(name: "Shaman", iconName: "shaman", nameColor: .blue, talentsBranches: [
            TalentBranch(name: "Elemental", background: "shamanElemental", icon: "shaman-elemental-icon"),
            TalentBranch(name: "Enhancement", background: "shamanEnhancement", icon: "shaman-enhancement-icon"),
            TalentBranch(name: "Restoration", background: "shamanRestoration", icon: "shaman-restoration-icon")
        ]),
        CharacterClass(name: "Warlock", iconName: "warlock", nameColor: .purple, talentsBranches: [
            TalentBranch(name: "Affliction", background: "warlockAffliction", icon: "warlock-affliction-icon"),
            TalentBranch(name: "Demonology", background: "warlockDemonology", icon: "warlock-demonology-icon"),
            TalentBranch(name: "Destruction", background: "warlockDestruction", icon: "warlock-destruction-icon")
        ]),
        CharacterClass(name: "Warrior", iconName: "warrior", nameColor: .brown, talentsBranches: [
            TalentBranch(name: "Arms", background: "warriorArms", icon: "warrior-arms-icon"),
            TalentBranch(name: "Fury", background: "warriorFury", icon: "warrior-fury-icon"),
            TalentBranch(name: "Protection", background: "warriorProtection", icon: "warrior-protection-icon")
        ])
    ]
}
