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
    @Published var loadingString: String?

    init(characterClass: CharacterClass, loadType: LoadType, loadingString: String?) {
        switch loadType {
        case .fromDefault:
            self.characterClass = characterClass
            loadTalents(characterClass: characterClass)

        case .fromSaves:
            self.characterClass = characterClass
            loadTalents(characterClass: characterClass)
            self.loadingString = loadingString
            if let talentString = loadingString {
                self.loadingString = talentString
                loadTalentsFromString(talentString: talentString)
            } else {
                print("No talent string provided")
            }
        }
    }

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
            }
        }
        return 51 - countPoints
    }

    func branchPointAsString() -> String {
        return branchPoints.map { String($0) }.joined(separator: "/")
    }

    func loadTalents(characterClass: CharacterClass) {
        var talents = [[Talent]?](repeating: nil, count: characterClass.talentsBranches.count)

        for (index, talentTree) in characterClass.talentsBranches.enumerated() {
            let filename = "\(characterClass.name.lowercased())\(talentTree.name.replacingOccurrences(of: " ", with: ""))"
            do {
                let loadedTalents = try loadTalentsFromJSON(named: filename)
                talents[index] = loadedTalents
            } catch {
                errorMessage = "Не удалось загрузить таланты для ветки \(talentTree.name): \(error)"
            }
        }

        for (index, talentList) in talents.enumerated() {
            if let talentList = talentList {
                self.characterClass.talentsBranches[index].talents = talentList
            }
        }
    }

    func loadTalentsFromJSON(named fileName: String) throws -> [Talent] {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "TalentLoaderError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл \(fileName).json не найден"])
        }

        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        return try decoder.decode([Talent].self, from: data)
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

    func createTalentString(for charClass: CharacterClass) -> String {
        var talentString = ""

        for branch in charClass.talentsBranches {
            guard let talents = branch.talents else {
                continue
            }

            for talent in talents {
                talentString += "\(talent.currentPoints)"
            }
        }
        print(talentString)
        return talentString
    }

    func loadTalentsFromString(talentString: String) {
        let talentStringChars = Array(talentString)
        var stringIndex = 0

        for branchIndex in characterClass.talentsBranches.indices {
            guard let talents = characterClass.talentsBranches[branchIndex].talents else {
                continue
            }

            for talentIndex in talents.indices {
                if stringIndex < talentStringChars.count,
                   let value = Int(String(talentStringChars[stringIndex]))
                {
                    characterClass.talentsBranches[branchIndex].talents?[talentIndex].currentPoints = value
                    stringIndex += 1
                }
            }
        }
    }

    func saveBuild(talentBuild: TalentBuild) -> Bool {
        let defaults = UserDefaults.standard
        var savedBuilds: [TalentBuild] = loadSavedBuilds() ?? []
        savedBuilds.append(talentBuild)
        do {
            let encoded = try JSONEncoder().encode(savedBuilds)
            defaults.set(encoded, forKey: "builds")
            return true
        } catch {
            print("Failed to encode TalentBuilds: \(error)")
            return false
        }
    }

    func loadSavedBuilds() -> [TalentBuild]? {
        let defaults = UserDefaults.standard
        guard let savedData = defaults.data(forKey: "builds") else {
            print("No saved data found for key 'builds'")
            return nil
        }
        do {
            let decoded = try JSONDecoder().decode([TalentBuild].self, from: savedData)
            return decoded
        } catch {
            print("Failed to decode TalentBuild: \(error)")
            return nil
        }
    }
}
