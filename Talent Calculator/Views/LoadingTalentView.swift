//
//  LoadingTalentView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 05/06/2024.
//

import SwiftUI

struct LoadingTalentView: View {
    @State private var listOfBuilds: [TalentBuild] = []
    @State private var showAlert = false
    @State private var buildToDelete: TalentBuild?

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

                                        VStack(alignment: .leading) {
                                            Text(build.name)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                                .multilineTextAlignment(.leading)
                                            Text(build.pointsSpend)
                                        }
                                        .padding()

                                        Spacer()

                                        Button(action: {
                                            buildToDelete = build
                                            showAlert = true
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                                .font(.title2)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                        .padding()
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete Build"),
                message: Text("Are you sure you want to delete this build?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let buildToDelete = buildToDelete {
                        deleteBuild(build: buildToDelete)
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            listOfBuilds = loadSavedBuilds() ?? []
        }
    }

    private func deleteBuild(build: TalentBuild) {
        listOfBuilds.removeAll { $0.name == build.name }
        saveBuilds(builds: listOfBuilds)
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

func saveBuilds(builds: [TalentBuild]) {
    let defaults = UserDefaults.standard
    do {
        let encodedData = try JSONEncoder().encode(builds)
        defaults.set(encodedData, forKey: "builds")
    } catch {
        print("Failed to encode TalentBuild: \(error)")
    }
}

func indexOfCharacterClass(withName name: String) -> Int? {
    return CharacterData.characterClasses.firstIndex(where: { $0.name == name })
}


#Preview {
    LoadingTalentView()
}
