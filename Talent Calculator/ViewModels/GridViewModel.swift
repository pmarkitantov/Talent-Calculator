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
    private var className: String
    @Published var talentsBranches: [TalentBranch]
    @Published var errorMessage: String?
    var tapCount = 0
    private var lastSelectedTalentId: UUID?

    var branchPoint = [0, 0, 0]
    var pointsLeft = 51

    func branchPointAsString() -> String {
        return branchPoint.map { String($0) }.joined(separator: "/")
    }

    init(characterClass: CharacterClass, loadType: LoadType) {
        switch loadType {
        case .fromDefault:
            self.talentsBranches = characterClass.talentTrees
            className = characterClass.name
            Task { await loadTalents(characterClass: characterClass) }
        case .fromSaves:
            self.talentsBranches = characterClass.talentTrees
            className = characterClass.name
            Task { await loadTalents(characterClass: characterClass) }
        }
    }
    
    func loadDataFromFile<T: Decodable>(filename: String, type: T.Type) -> T? {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let loadedData = try decoder.decode(type, from: data)
            return loadedData
        } catch {
            print("Failed to load data: \(error)")
            return nil
        }
    }

    func saveDataToFile(data: Codable, filename: String) {
        do {
            let url = getDocumentsDirectory().appendingPathComponent("\(filename).json")
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
            print("Data saved to \(url)")
        } catch {
            print("Failed to save data: \(error)")
        }
    }

    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func fileExists(filename: String) -> Bool {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    func generateUniqueFilename(base: String) -> String {
        let uuid = UUID().uuidString
        return "\(base)--\(uuid).json"
    }

    func saveDataConditionally(data: Codable, filename: String) {
        let fullPath = generateUniqueFilename(base: filename) // Используйте уникальный ID
        if fileExists(filename: fullPath) {
            // Обработка случая, когда файл уже существует
            print("File already exists. Consider renaming or overwriting.")
        } else {
            saveDataToFile(data: data, filename: fullPath)
        }
    }
    
    func getListOfSavedFiles() -> [String] {
        do {
            let documentsURL = getDocumentsDirectory()
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            
            return fileURLs.filter { $0.pathExtension == "json" }.map { $0.lastPathComponent }
        } catch {
            print("Error while enumerating files \(getDocumentsDirectory().path): \(error.localizedDescription)")
            return []
        }
    }
    
    func suggestNewFilename(originalFilename: String) -> String {
        var newFilename = originalFilename
        var count = 1
        while fileExists(filename: newFilename) {
            newFilename = "\(originalFilename)_\(count)"
            count += 1
        }
        return newFilename
    }

    @MainActor
    func loadTalents(characterClass: CharacterClass) async {
        var talents = [[Talent]?](repeating: nil, count: talentsBranches.count)

        await withTaskGroup(of: (Int, [Talent]?).self) { group in
            for (index, talentTree) in characterClass.talentTrees.enumerated() where index < talentsBranches.count {
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
                talentsBranches[index].talents = talentList
            }
        }
    }

    func isTalentActive(talent: Talent, branchIndex: Int) -> Bool {
        guard let dependencyName = talent.dependencyName else {
            return talent.requiredPoints <= branchPoint[branchIndex] && pointsLeft > 0
        }
        guard let requiredTalent = talentsBranches[branchIndex].talents?.first(where: { $0.name == dependencyName }) else {
            return false
        }

        let isRequiredTalentMaxed = requiredTalent.currentPoints == requiredTalent.maxPoints
        let hasSufficientBranchPoints = talent.requiredPoints <= branchPoint[branchIndex]
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
        for talentBrach in talentsBranches {
            if let talent = talentBrach.talents!.first(where: { $0.id == talentId }) {
                return talent.baseDescription
            }
        }
        return "error"
    }

    func showTalentName(for taletId: UUID) -> String {
        for talentsBranch in talentsBranches {
            if let talent = talentsBranch.talents!.first(where: { $0.id == taletId }) {
                return talent.name
            }
        }
        return ""
    }

    func showTalentRank(for taletId: UUID) -> String {
        for talentsBranch in talentsBranches {
            if let talent = talentsBranch.talents!.first(where: { $0.id == taletId }) {
                return "\(talent.currentPoints)/\(talent.maxPoints)"
            }
        }
        return ""
    }

    func incrementCount(for elementID: UUID, inBranch branchIndex: Int) {
        if let talentIndex = talentsBranches[branchIndex].talents!.firstIndex(where: { $0.id == elementID }) {
            var talent = talentsBranches[branchIndex].talents![talentIndex]

            if talent.currentPoints < talent.maxPoints {
                talent.currentPoints += 1
                branchPoint[branchIndex] += 1
                pointsLeft -= 1
                talentsBranches[branchIndex].talents![talentIndex] = talent
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

    func resetTalent() {
        DispatchQueue.global(qos: .userInitiated).async {
            for index in 0..<self.talentsBranches.count {
                if let talents = self.talentsBranches[index].talents {
                    for i in 0..<talents.count {
                        self.talentsBranches[index].talents![i].currentPoints = 0
                    }
                }
            }

            self.pointsLeft = 51
            self.branchPoint = [0, 0, 0]

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
}
