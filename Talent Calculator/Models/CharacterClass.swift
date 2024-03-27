//
//  CharacterClass.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

struct CharacterClass: Decodable, Identifiable {
    var id: UUID?
    let name, icon: String
    let talentTrees: [TalentTree]
}

// MARK: - TalentTree
struct TalentTree: Decodable {
    let name: String
    let talents: [Talent]
}

// MARK: - Talent
struct Talent: Decodable {
    let name: String
    let iconURL: String
    let baseDescription: String
    let maxPoints, currentPoints, requiredPoints, row: Int
    let column: Int
}







