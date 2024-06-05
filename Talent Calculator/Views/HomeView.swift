//
//  HomeView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 05/06/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .blur(radius: 10)

                VStack(spacing: 20) {
                    HStack {
                        Text("Welcome to Talent Builder")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding()

                    CustomNavigationLink(destination: ClassesListView(), imageName: "plus.app", label: "Create New Build")
                    CustomNavigationLink(destination: LoadingTalentView(), imageName: "folder", label: "Load Saved Builds")
                    CustomNavigationLink(destination: LoadingCommunityBuilds(), imageName: "person.3", label: "Load Community Builds")

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
