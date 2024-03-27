//
//  CharacterClassesViewModel.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import UIKit

func load<T: Decodable>(_ filename: String) throws -> T {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Не удалось найти файл \(filename) в основном бандле.")
    }

    let data = try Data(contentsOf: fileURL)
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
}


class CharacterClassesViewModel: ObservableObject {
    @Published var characterClasses: [CharacterClass] = []

    init() {
        loadCharacterClasses()
    }

    func loadCharacterClasses() {
        do {
            if let loadedClasses: [CharacterClass] = try load("TalentsData.json") {
                self.characterClasses = loadedClasses
            }
        } catch {
            print("Failed to load character classes 1488: \(error)")
            
        }
    }
}



