//
//  CharacterClass.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import SwiftUI


struct Arrow: Decodable {
    let image: String
    let side: String
    let size: String
}

struct TalentBranch {
    let name: String
    let background: String
    let icon: String
    var talents: [Talent]?
    var spentPointsInBranch: Int = 0
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

    init(name: String, icon: String, baseDescription: String, currentPoints: Int = 0, maxPoints: Int, requiredPoints: Int, row: Int, column: Int, arrow: Arrow? = nil, dependencyName: String? = nil) {
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
        self.dependencyName = dependencyName
    }
}
