//
//  GridViewModel.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

class GridViewModel: ObservableObject {
    @Published var talentsBranches: [[Talent]] = [[], [], []]
    
    init(chatacterClass: CharacterClass) {
        loadTalents(characterClass: chatacterClass)
    }

    func loadTalents(characterClass: CharacterClass) {
        talentsBranches = [[], [], []] // Переинициализация

        Task {
            for (index, talentTree) in characterClass.talentTrees.enumerated() where index < talentsBranches.count {
                do {
//                    let filename = characterClass.name.lowercased() + talentTree.name
                    let talents = try await loadTalentsFromJSON(named: "testDruidBalance")
                    DispatchQueue.main.async { [weak self] in
                        self?.talentsBranches[index] = talents
                    }
                } catch {
                    print("Не удалось загрузить таланты для ветки \(talentTree.name): \(error)")
                    // Массив для этой ветки остается пустым
                }
            }
        }
    }


    private func loadTalentsFromJSON(named fileName: String) async throws -> [Talent] {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "TalentLoaderError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл \(fileName).json не найден"])
        }

        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        return try decoder.decode([Talent].self, from: data)
    }
    
    func incrementCount(for elementID: UUID, inBranch branchIndex: Int) {
        guard branchIndex < talentsBranches.count else { return }

        if let index = talentsBranches[branchIndex].firstIndex(where: { $0.id == elementID }) {
            if talentsBranches[branchIndex][index].currentPoints < talentsBranches[branchIndex][index].maxPoints {
                talentsBranches[branchIndex][index].currentPoints += 1
                // Обновляем данные, чтобы изменения отразились в UI
                objectWillChange.send()
            }
        }
    }

}
