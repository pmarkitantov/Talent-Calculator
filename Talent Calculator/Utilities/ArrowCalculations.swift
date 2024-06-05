//
//  ArrowCalculations.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 04/06/2024.
//

import Foundation
import SwiftUI

enum ArrowCalculations {
    static func xOffset(for arrow: Arrow, with cellWidth: CGFloat) -> CGFloat {
        switch arrow.side {
        case "left":
            return -cellWidth / 2
        case "right":
            return cellWidth / 4
        case "topLeft":
            return -cellWidth / 4 + 5
        default:
            return 0
        }
    }

    static func yOffset(for arrow: Arrow, with cellHeight: CGFloat) -> CGFloat {
        switch (arrow.side, arrow.size) {
        case ("top", "short"):
            return -cellHeight / 2 - 10
        case ("top", "medium"):
            return -cellHeight - 20
        case ("topLeft", _):
            return -cellHeight
        case("top", "long"):
            return -cellHeight * 2 + 10
        default:
            return 0
        }
    }

    static func frameWidth(for arrow: Arrow, _ cellWidth: CGFloat) -> CGFloat {
        switch (arrow.side, arrow.size) {
        case("topLeft", "medium"):
            return cellWidth
        case ("left", _):
            return cellWidth / 2
        case (_, "short"):
            return cellWidth / 1.6
        case (_, "medium"), (_, "long"):
            return cellWidth
        default:
            return cellWidth / 2 + 20
        }
    }

    static func frameHeight(for arrow: Arrow, _ cellHeight: CGFloat) -> CGFloat {
        switch (arrow.side, arrow.size) {
        case ("left", "short"):
            return cellHeight / 1.7
        case ("top", "medium"):
            return cellHeight * 2 - 15
        case("topLeft", "medium"):
            return cellHeight + 10
        case("top", "long"):
            return cellHeight * 3
        default:
            return cellHeight
        }
    }
}
