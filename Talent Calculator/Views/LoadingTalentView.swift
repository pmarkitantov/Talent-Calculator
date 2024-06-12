//
//  LoadingTalentView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 05/06/2024.
//

import SwiftUI

struct LoadingTalentView: View {
    @State private var listOfBuilds: [TalentBuild] = loadSavedBuilds() ?? []

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .blur(radius: 10)

                VStack(spacing: 20) {
                    HStack {
                        Text("Saved Builds")
                            .font(.largeTitle)
                            .fontWeight(.semibold)

                        Spacer()
                    }
                    .padding()

                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(listOfBuilds, id: \.name) { build in
                                let classIndex = indexOfCharacterClass(withName: build.className.capitalizingFirstLetter())!
                                NavigationLink(destination: TalentsTreeView(characterClass: CharacterData.characterClasses[classIndex], loadType: .fromSaves, loadingString: build.talentPointsString)) {
                                    HStack {
                                        Image(build.imageName)

                                        Text(build.name)
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                            .padding()

                                        Spacer()
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.thinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
                .scrollContentBackground(.hidden)

                Spacer()
            }
        }
    }
}

func loadSavedBuilds() -> [TalentBuild]? {
    let defaults = UserDefaults.standard
    guard let savedData = defaults.data(forKey: "builds") else {
        print("No saved data found for key 'builds'")
        return nil
    }
    do {
        let decoded = try JSONDecoder().decode([TalentBuild].self, from: savedData)
        return decoded
    } catch {
        print("Failed to decode TalentBuild: \(error)")
        return nil
    }
}

func indexOfCharacterClass(withName name: String) -> Int? {
    return CharacterData.characterClasses.firstIndex(where: { $0.name == name })
}

#Preview {
    LoadingTalentView()
}
