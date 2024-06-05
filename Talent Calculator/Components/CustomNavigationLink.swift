//
//  CustomNavigationLink.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 05/06/2024.
//

import Foundation
import SwiftUI

struct CustomNavigationLink<Destination: View>: View {
    var destination: Destination
    var imageName: String
    var label: String

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageName)
                Text(label)
            }
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
        }
    }
}
