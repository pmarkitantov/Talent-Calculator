//
//  ContentView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 1
    
    var body: some View {
        TestGridView(viewModel: GridViewModel(talentTreeName: "testDruidBalance"))
    }
}

#Preview {
    ContentView()
}
