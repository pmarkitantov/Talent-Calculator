//
//  Talent_CalculatorApp.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI

@main
struct Talent_CalculatorApp: App {
    @State private var selectedTab: Int = 1
    @StateObject var gridViewModel: GridViewModel = .init(talentTreeName: "testDruidBalance")
    
    var body: some Scene {
        WindowGroup {
            TestGridView()
        }
        .environmentObject(gridViewModel)
    }
}
