//
//  CharacterClass.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import SwiftUI

// enum Direction: String {
//    case up, down, left, right
// }

struct TalentDependency: Codable {
    var talentName: String
    var requiredPoints: Int
}

struct TalentPosition {
    var id: UUID
    var name: String
    var rect: CGRect
}


// Структура Arrow с параметрами: направление, размер и название изображения
struct Arrow: Decodable {
    let image: String
    var isActive: Bool
    let toggleTalentName: String
    let displaySide: String
}

struct TalentTree {
    let name: String
    let background: String
    let icon: String
}

enum TalentBranches {
    static let branches: [String: [String]] = [
        "druid": ["Balance", "Feral", "Restoration"],
        "warrior": ["Arms", "Fury", "Protection"],
        "paladin": ["Holy", "Protection", "Retribution"],
        "hunter": ["Beast Mastery", "Marksmanship", "Survival"],
        "rogue": ["Assassination", "Outlaw", "Subtlety"],
        "priest": ["Discipline", "Holy", "Shadow"],
        "shaman": ["Elemental", "Enhancement", "Restoration"],
        "mage": ["Arcane", "Fire", "Frost"],
        "warlock": ["Affliction", "Demonology", "Destruction"]
    ]
}

struct Talent: Identifiable, Decodable {
    var id: UUID
    let name: String
    let icon: String
    let baseDescription: String
    var currentPoints: Int
    let maxPoints: Int
    let requiredPoints: Int
    let row: Int
    let column: Int
    let arrow: Arrow?
    var dependencies: [TalentDependency]?

    enum CodingKeys: String, CodingKey {
        case name, icon, baseDescription, currentPoints, maxPoints, requiredPoints, row, column, arrow, dependencies
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = UUID() // Генерируется автоматически
        name = try container.decode(String.self, forKey: .name)
        icon = try container.decode(String.self, forKey: .icon)
        baseDescription = try container.decode(String.self, forKey: .baseDescription)
        currentPoints = try container.decode(Int.self, forKey: .currentPoints)
        maxPoints = try container.decode(Int.self, forKey: .maxPoints)
        requiredPoints = try container.decode(Int.self, forKey: .requiredPoints)
        row = try container.decode(Int.self, forKey: .row)
        column = try container.decode(Int.self, forKey: .column)
        arrow = try container.decodeIfPresent(Arrow.self, forKey: .arrow)
        dependencies = try container.decodeIfPresent([TalentDependency].self, forKey: .dependencies)
        
    }

    // Дополнительный инициализатор для создания объектов в коде
    init(name: String, icon: String, baseDescription: String, currentPoints: Int = 0, maxPoints: Int, requiredPoints: Int, row: Int, column: Int, arrow: Arrow? = nil) {
        id = UUID()
        self.name = name
        self.icon = icon
        self.baseDescription = baseDescription
        self.currentPoints = currentPoints
        self.maxPoints = maxPoints
        self.requiredPoints = requiredPoints
        self.row = row
        self.column = column
        self.arrow = arrow
    }
}
