//
//  GridViewModel.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

class GridViewModel: ObservableObject {
    @Published var talentsBranches: [TalentBranch]

    var branchPoint = [0, 0, 0]
    var totalPoints = 0

    init(chatacterClass: CharacterClass) {
        self.talentsBranches = chatacterClass.talentTrees
        loadTalents(characterClass: chatacterClass)
    }

    func loadTalents(characterClass: CharacterClass) {
        Task {
            for (index, talentTree) in characterClass.talentTrees.enumerated() where index < talentsBranches.count {
                do {
                    let filename = characterClass.name.lowercased() + talentTree.name
                    let talents = try await loadTalentsFromJSON(named: filename)
                    DispatchQueue.main.async { [weak self] in
                        self?.talentsBranches[index].talents = talents
                    }
                } catch {
                    print("Не удалось загрузить таланты для ветки \(talentTree.name): \(error)")
                }
            }
        }
    }

    func isTalentActive(talent: Talent, branchIndex: Int) -> Bool {
        guard let dependencyName = talent.dependencyName else {
            return talent.requiredPoints <= branchPoint[branchIndex]
        }
        guard let requiredTalent = talentsBranches[branchIndex].talents?.first(where: { $0.name == dependencyName }) else { return false }

        return requiredTalent.currentPoints == requiredTalent.maxPoints && talent.requiredPoints <= branchPoint[branchIndex]
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
        if let index = talentsBranches[branchIndex].talents!.firstIndex(where: { $0.id == elementID }) {
            if talentsBranches[branchIndex].talents![index].currentPoints < talentsBranches[branchIndex].talents![index].maxPoints {
                talentsBranches[branchIndex].talents![index].currentPoints += 1
                branchPoint[branchIndex] += 1
                totalPoints += 1
                objectWillChange.send()
            }
        }
    }
}
