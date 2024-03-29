//
//  TestGridView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 29/03/2024.
//

import SwiftUI

struct TestGridView: View {
    @ObservedObject var viewModel: GridViewModel
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @State private var positions: [Int: CGRect] = [:]

    var body: some View {
        ScrollView {
            ZStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(viewModel.talents.enumerated()), id: \.element.id) { index, talent in
                        GeometryReader { geometry in
                            Image(talent.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .background(GeometryReader { geo in
                                    Color.clear.onAppear {
                                        positions[index] = geo.frame(in: .global)
                                    }
                                })
                        }
                        .frame(height: 100)
                    }
                }

                ForEach(positions.keys.sorted(), id: \.self) { index in
                    if let currentRect = positions[index], viewModel.talents[index].arrow != nil {
                        Image("ArrowMedium")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height:150)
                            .position(x: currentRect.midX, y: (currentRect.maxY + 15))
                    }
                }
            }
        }
    }
}


#Preview {
    TestGridView(viewModel: GridViewModel(talentTreeName: "testDruidBalance"))
}
