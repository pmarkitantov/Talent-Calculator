//
//  TalentsTreeView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation
import SwiftUI

struct TalentsTreeView: View {
    let characterClass: CharacterClass
    let loadType: LoadType
    @State var loadingString: String?
    @ObservedObject var viewModel: GridViewModel
    @State private var selectedTab: Int = 0
    @State var selectedTalentId = UUID()
    @State var showDescription: Bool = false
    @State private var showSaveAlert: Bool = false
    @State var textfieldInput = ""
    @State private var showErrorAlert = false
    @State private var showNameAlert = false
    @State var saveSuccessful: Bool = true

    init(characterClass: CharacterClass, loadType: LoadType, loadingString: String? = nil) {
        self.characterClass = characterClass
        self.loadType = loadType
        self.loadingString = loadingString

        self.viewModel = GridViewModel(characterClass: characterClass, loadType: loadType, loadingString: loadingString)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if let tree = characterClass.talentsBranches.indices.contains(selectedTab) ? characterClass.talentsBranches[selectedTab] : nil {
                    Image(tree.background)
                        .resizable()
                        .ignoresSafeArea()

                    VStack(spacing: 0) {
                        header
                            .padding([.horizontal, .top])

                        TalentGridView(viewModel: self.viewModel, selectedTalentId: self.$selectedTalentId, selectedBranchIndex: self.selectedTab)
                            .padding(.horizontal)

                        if self.showDescription {
                            descriptionView
                                .padding([.bottom, .horizontal])
                        }

                        TabbarButtonView(talentTrees: self.characterClass.talentsBranches, selectedTab: self.$selectedTab)
                            .shadow(color: Color(self.characterClass.nameColor).opacity(10), radius: 5, x: 0, y: 0)
                            .padding(.horizontal)
                    }

                    .onChange(of: self.selectedTalentId) {
                        self.showDescription = true
                    }
                } else {
                    Text("Выбранная вкладка недоступна")
                        .ignoresSafeArea()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if self.viewModel.pointsLeft == 51 {
                            self.showErrorAlert.toggle()
                        } else {
                            self.showSaveAlert.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Save build")
                            Image(systemName: "square.and.arrow.down")
                        }
                        .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.viewModel.resetTalents()
                    } label: {
                        HStack {
                            Text("Reset")
                            Image(systemName: "trash")
                        }
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                    }
                }
            }
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .alert("Save Build", isPresented: self.$showSaveAlert) {
                TextField("Enter name", text: self.$textfieldInput)
                Button("Cancel", role: .cancel) {}
                Button("Save Build", action: {
                    if self.textfieldInput.isEmpty {
                        self.showErrorAlert = true
                    } else {
                        let newBuild = TalentBuild(name: textfieldInput, className: characterClass.name, imageName: self.characterClass.iconName, talentPointsString: self.viewModel.createTalentString(for: self.viewModel.characterClass), pointsSpend: self.viewModel.branchPointAsString())
                        print(newBuild.talentPointsString)
                        self.saveSuccessful = self.viewModel.saveBuild(talentBuild: newBuild)
                        if self.saveSuccessful == false {
                            self.showErrorAlert = true
                        }
                    }
                })
                .foregroundStyle(.green)
            } message: {
                Text("Please enter the name for your build")
            }
            .alert("Error", isPresented: self.$showErrorAlert) {
                Button("OK", role: .cancel) {
                    if !saveSuccessful {
                        showSaveAlert.toggle()
                    }
                }
            } message: {
                if self.viewModel.pointsLeft == 51 {
                    Text("The build cannot be empty.")
                } else if !saveSuccessful {
                    Text("A build with this name already exists. Please choose a different name.")
                } else {
                    Text("The name field cannot be empty.")
                }
            }
        }
    }
}

extension TalentsTreeView {
    var header: some View {
        HStack {
            Image(self.characterClass.iconName)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color(self.characterClass.nameColor), lineWidth: 2)
                }

            Text(self.characterClass.name)
                .foregroundStyle(Color(self.characterClass.nameColor))
            Text("(\(self.viewModel.branchPointAsString()))")

            Spacer()
            Text("Points left: \(self.viewModel.pointsLeft)")
        }
        .font(.headline)
        .fontWeight(.bold)
        .foregroundStyle(.accent)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(self.characterClass.nameColor, lineWidth: 2)
        }
        .shadow(color: Color(characterClass.nameColor).opacity(0.5), radius: 5, x: 0, y: 0)
    }

    private var descriptionView: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(self.viewModel.showTalentName(for: self.selectedTalentId))
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("Rank: \(self.viewModel.showTalentRank(for: self.selectedTalentId))")
                        .foregroundStyle(.secondary)
                }
                .padding(.leading)
                Spacer()
            }
            Text(self.viewModel.showDescription(for: self.selectedTalentId))
                .padding(.horizontal)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(alignment: .topTrailing) {
            Button {
                if self.viewModel.tapCount > 1 {
                    self.viewModel.tapCount = 0
                }
                self.showDescription = false
            }
            label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(10)
                    .foregroundStyle(.red)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
            }
        }
    }
}

#Preview {
    TalentsTreeView(characterClass: CharacterData.characterClasses[6], loadType: .fromDefault)
}
