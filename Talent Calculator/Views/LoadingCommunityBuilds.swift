//
//  LoadingCommunityBuilds.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 05/06/2024.
//

import SwiftUI

struct LoadingCommunityBuilds: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .blur(radius: 10)

                VStack(spacing: 20) {
                    HStack {
                        Text("Community Builds")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding()

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoadingCommunityBuilds()
}
