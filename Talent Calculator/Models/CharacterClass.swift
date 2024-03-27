//
//  CharacterClass.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

struct CharacterClass: Identifiable {
    let id: UUID = UUID()
    let name: String
    let icon: String
    let talentTrees: [TalentCategory]
}

struct TalentCategory {
    let name: String
    let talents: [Talent] 
}




