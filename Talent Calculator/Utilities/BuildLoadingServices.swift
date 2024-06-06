//
//  BuildLoadingServices.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 06/06/2024.
//

import Foundation

struct BuildLoadingServices {
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
}
