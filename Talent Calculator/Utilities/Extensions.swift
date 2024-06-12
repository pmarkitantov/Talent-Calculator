//
//  Extensions.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 12/06/2024.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        guard !self.isEmpty else { return self }
        return self.prefix(1).uppercased() + self.dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
