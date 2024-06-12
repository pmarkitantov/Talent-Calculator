//
//  GridViewModel.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Combine
import Foundation
import SwiftUI

class GridViewModel: ObservableObject {
    @Published var characterClass: CharacterClass
    @Published var errorMessage: String?
    var tapCount = 0
    private var lastSelectedTalentId: UUID?

    var branchPoints: [Int] {
        var branchPointsCount = [0, 0, 0]
        for index in characterClass.talentsBranches.indices {
            if let talents = characterClass.talentsBranches[index].talents {
                for talent in talents {
                    if talent.currentPoints > 0 {
                        branchPointsCount[index] += Int(talent.currentPoints)
                    }
                }
            }
        }
        return branchPointsCount
    }

    var pointsLeft: Int {
        var countPoints = 0
        for branch in characterClass.talentsBranches {
            if let talents = branch.talents {
                for talent in talents {
                    if talent.currentPoints > 0 {
                        countPoints += Int(talent.currentPoints)
                    }
                }
            } else {
                print("Talents are nil for branch \(branch.name)")
            }
        }
        return 51 - countPoints
    }

    func branchPointAsString() -> String {
        return branchPoints.map { String($0) }.joined(separator: "/")
    }

    init(characterClass: CharacterClass, loadType: LoadType) {
        switch loadType {
        case .fromDefault:
            self.characterClass = characterClass
            Task { await loadTalents(characterClass: characterClass) }

        case .fromSaves:
            self.characterClass = characterClass
            Task { await loadTalents(characterClass: characterClass) }
        }
    }

    @MainActor
    func loadTalents(characterClass: CharacterClass) async {
        var talents = [[Talent]?](repeating: nil, count: self.characterClass.talentsBranches.count)

        await withTaskGroup(of: (Int, [Talent]?).self) { group in
            for (index, talentTree) in characterClass.talentsBranches.enumerated() where index < self.characterClass.talentsBranches.count {
                group.addTask {
                    let filename = characterClass.name.lowercased() + talentTree.name.replacingOccurrences(of: " ", with: "")
                    do {
                        let talents = try await self.loadTalentsFromJSON(named: filename)
                        return (index, talents)
                    } catch {
                        DispatchQueue.main.async {
                            self.errorMessage = "Не удалось загрузить таланты для ветки \(talentTree.name): \(error)"
                        }
                        return (index, nil)
                    }
                }
            }

            for await result in group {
                talents[result.0] = result.1
            }
        }

        for (index, talentList) in talents.enumerated() {
            if let talentList = talentList {
                self.characterClass.talentsBranches[index].talents = talentList
            }
        }
    }

    func isTalentActive(talent: Talent, branchIndex: Int) -> Bool {
        guard let dependencyName = talent.dependencyName else {
            return talent.requiredPoints <= branchPoints[branchIndex] && pointsLeft > 0
        }
        guard let requiredTalent = characterClass.talentsBranches[branchIndex].talents?.first(where: { $0.name == dependencyName }) else {
            return false
        }

        let isRequiredTalentMaxed = requiredTalent.currentPoints == requiredTalent.maxPoints
        let hasSufficientBranchPoints = talent.requiredPoints <= branchPoints[branchIndex]
        let hasAvailableTotalPoints = pointsLeft > 0

        return isRequiredTalentMaxed && hasSufficientBranchPoints && hasAvailableTotalPoints
    }

    private func loadTalentsFromJSON(named fileName: String) async throws -> [Talent] {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "TalentLoaderError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл \(fileName).json не найден"])
        }

        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        return try decoder.decode([Talent].self, from: data)
    }

    func showDescription(for talentId: UUID) -> String {
        for talentBrach in characterClass.talentsBranches {
            if let talent = talentBrach.talents!.first(where: { $0.id == talentId }) {
                return talent.baseDescription
            }
        }
        return "error"
    }

    func showTalentName(for taletId: UUID) -> String {
        for talentsBranch in characterClass.talentsBranches {
            if let talent = talentsBranch.talents!.first(where: { $0.id == taletId }) {
                return talent.name
            }
        }
        return ""
    }

    func showTalentRank(for taletId: UUID) -> String {
        for talentsBranch in characterClass.talentsBranches {
            if let talent = talentsBranch.talents!.first(where: { $0.id == taletId }) {
                return "\(talent.currentPoints)/\(talent.maxPoints)"
            }
        }
        return ""
    }

    func incrementCount(for elementID: UUID, inBranch branchIndex: Int) {
        if let talentIndex = characterClass.talentsBranches[branchIndex].talents!.firstIndex(where: { $0.id == elementID }) {
            var talent = characterClass.talentsBranches[branchIndex].talents![talentIndex]

            if talent.currentPoints < talent.maxPoints {
                talent.currentPoints += 1
                characterClass.talentsBranches[branchIndex].talents![talentIndex] = talent
                objectWillChange.send()
            }
        }
    }

    func handleButtonTap(for talentId: UUID, inBranch branchIndex: Int, selectedTalentId: inout UUID) {
        if lastSelectedTalentId != talentId {
            tapCount = 0
            lastSelectedTalentId = talentId
        }
        if tapCount == 0 {
            selectedTalentId = talentId
        } else if tapCount > 0 {
            incrementCount(for: talentId, inBranch: branchIndex)
        }
        tapCount += 1
    }

    func resetTalents() {
        for (index, talentsBranch) in characterClass.talentsBranches.enumerated() {
            for talentIndex in talentsBranch.talents!.indices {
                characterClass.talentsBranches[index].talents![talentIndex].currentPoints = 0
            }
        }
    }
}
