//
//  CharacterClass.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

struct CharacterClass: Decodable, Identifiable {
    var id = UUID()
    let name, icon: String
    let talentTrees: [TalentTree]
}

// MARK: - TalentTree
struct TalentTree: Decodable {
    let name: String
    let talents: [Talent]
}

// MARK: - Talent
struct Talent: Decodable, Identifiable {
    var id: UUID = UUID() // Автоматически назначается при инициализации
    let name: String
    let icon: String
    let baseDescription: String
    var currentPoints: Int = 0
    let maxPoints: Int
    let requiredPoints: Int
    let row: Int
    let column: Int

}
//extension Talent {
//    init(row: Int, column: Int) {
//        self.name = ""
//        self.icon = ""
//        self.baseDescription = ""
//        self.currentPoints = 0
//        self.maxPoints = 0
//        self.requiredPoints = 0
//        self.row = row
//        self.column = column
//    }
//}






