//
//  GridViewModel.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

class GridViewModel: ObservableObject {
    @Published var elements: [Talent] = []
    // Предполагаем, что сетка 7x4
    let totalRows = 7
    let totalColumns = 4

    init(elements: [Talent]) {
        // Заполнение таблицы элементами или пустыми местами
        self.elements = (1...totalRows).flatMap { row in
            (1...totalColumns).map { column in
                if let element = elements.first(where: { $0.row == row && $0.column == column }) {
                    return element
                } else {
                    // Создание пустого заполнителя для отсутствующих элементов
                    return Talent(name: "", icon: "", baseDescription: "", maxPoints: 0, requiredPoints: 0, row: 0, column: 0)
                }
            }
        }
    }

    func incrementCount(for elementID: UUID) {
        if let index = elements.firstIndex(where: { $0.id == elementID }) {
            let element = elements[index]
            // Проверка, чтобы убедиться, что текущее количество нажатий меньше максимально допустимого
            if element.currentPoints < element.maxPoints {
                elements[index].currentPoints += 1
            }
        }
    }
    
    func resetCurrentPoints() {
            for index in elements.indices {
                elements[index].currentPoints = 0
            }
        }
}
