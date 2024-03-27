//
//  CharacterClassesViewModel.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import UIKit

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) throws -> T? {
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("Couldn't find \(filename) in main bundle.")
        return nil
    }

    do {
        let data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Error while loading or parsing \(filename): \(error)")
        throw error
    }
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
            print("Failed to load character classes: \(error)")
            
        }
    }
}



