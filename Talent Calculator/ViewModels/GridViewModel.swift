//
//  GridViewModel.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

class GridViewModel: ObservableObject {
    @Published var talents: [Talent] = []

    let totalRows = 7
    let totalColumns = 4

    init(talentTreeName: String) {
        loadCharacterClasses(from: talentTreeName)
    }

    private func loadCharacterClasses(from talentTreeName: String) {
        talents = load(with: talentTreeName)
        fillMissingPlaces()
    }

    private func load(with talentTreeName: String) -> [Talent] {
        guard let fileURL = Bundle.main.url(forResource: talentTreeName, withExtension: "json") else {
            return [Talent]()
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode([Talent].self, from: data)
        } catch {
            return [Talent]()
        }
    }

    // Добавление метода для заполнения таблицы элементами или пустыми местами
    func fillMissingPlaces() {
        let elements = talents
        talents = (1...totalRows).flatMap { row in
            (1...totalColumns).map { column in
                if let element = elements.first(where: { $0.row == row && $0.column == column }) {
                    return element
                } else {
                    // Возвращение пустого заполнителя для отсутствующих элементов
                    return Talent(name: "", icon: "", baseDescription: "", maxPoints: 0, requiredPoints: 0, row: row, column: column)
                }
            }
        }
    }

    // Методы для работы с данными
    func incrementCount(for elementID: UUID) {
        if let index = talents.firstIndex(where: { $0.id == elementID }) {
            if talents[index].currentPoints < talents[index].maxPoints {
                talents[index].currentPoints += 1
            }
        }
    }

    func resetCurrentPoints() {
        for index in talents.indices {
            talents[index].currentPoints = 0
        }
    }
}
