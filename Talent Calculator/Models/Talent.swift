//
//  Talent.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

struct Talent {
    let id: String
    let name: String
    let iconURL: String
    let baseDescription: String // Базовое описание с местозаполнителями для времени действия обеих способностей
    let maxPoints: Int
    var currentPoints: Int
    let requiredPonts: Int
    let prerequisites: [String]
    let row: Int
    let column: Int
    let effectPerPoint: [String: [Int]] // Словарь для времени действия обеих способностей на каждом уровне таланта

    // Вычисляемое свойство для динамического формирования описания
    var currentDescription: String {
        var description = baseDescription
        for (placeholder, values) in effectPerPoint {
            if currentPoints > 0 && currentPoints <= values.count {
                let value = values[currentPoints - 1] // Используйте значение, соответствующее текущему количеству очков
                description = description.replacingOccurrences(of: "{\(placeholder)}", with: "\(value)")
            }
        }
        return description
    }
}
