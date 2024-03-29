//
//  Utilities.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 28/03/2024.
//

import Foundation
import SwiftUI
import UIKit

func customizeBackButton() {
        // Цвет кнопки Назад
        UINavigationBar.appearance().tintColor = UIColor.red
        
        // Шрифт и цвет текста кнопки Назад
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.blue
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        
        // Старый способ изменения текста кнопки Назад, который может не работать в последних версиях iOS
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
    }
