//
//  CharacterClass.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import SwiftUI

enum LoadType {
    case fromSaves
    case fromDefault
}

struct TalentBuild: Codable, Identifiable {
    var id = UUID()
    let name: String
    let className: String
    let imageName: String
    let talentPointsString: String
    let pointsSpend: String
}

struct Arrow: Codable {
    let image: String
    let side: String
    let size: String
}

struct TalentBranch: Codable {
    let name: String
    let background: String
    let icon: String
    var talents: [Talent]?
}

struct Talent: Identifiable, Codable {
    var id: UUID = .init()
    let name: String
    let icon: String
    let baseDescription: String
    var currentPoints: Int
    let maxPoints: Int
    let requiredPoints: Int
    let row: Int
    let column: Int
    let arrow: Arrow?
    var dependencyName: String?

    enum CodingKeys: String, CodingKey {
        case name, icon, baseDescription, currentPoints, maxPoints, requiredPoints, row, column, arrow, dependencyName
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
        dependencyName = try container.decodeIfPresent(String.self, forKey: .dependencyName)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(icon, forKey: .icon)
        try container.encode(baseDescription, forKey: .baseDescription)
        try container.encode(currentPoints, forKey: .currentPoints)
        try container.encode(maxPoints, forKey: .maxPoints)
        try container.encode(requiredPoints, forKey: .requiredPoints)
        try container.encode(row, forKey: .row)
        try container.encode(column, forKey: .column)
        try container.encodeIfPresent(arrow, forKey: .arrow)
        try container.encodeIfPresent(dependencyName, forKey: .dependencyName)
    }

    // Кастомый инициализатор для превьюшек

    init(name: String, icon: String, baseDescription: String, currentPoints: Int = 0, maxPoints: Int, requiredPoints: Int, row: Int, column: Int, arrow: Arrow? = nil, dependencyName: String? = nil) {
        self.name = name
        self.icon = icon
        self.baseDescription = baseDescription
        self.currentPoints = currentPoints
        self.maxPoints = maxPoints
        self.requiredPoints = requiredPoints
        self.row = row
        self.column = column
        self.arrow = arrow
        self.dependencyName = dependencyName
    }
}
