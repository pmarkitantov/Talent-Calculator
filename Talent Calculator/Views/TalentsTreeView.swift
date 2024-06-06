//
//  TalentsTreeView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import SwiftUI

struct TalentsTreeView: View {
    let characterClass: CharacterClass
    @ObservedObject var viewModel: GridViewModel
    @State private var selectedTab: Int = 0
    @State var selectedTalentId = UUID()
    @State var showDescription: Bool = false
    @State private var showSaveSheet: Bool = false
    @State var textfieldInput = ""
    @State var filename = ""
    @State private var showErrorAlert = false

    init(characterClass: CharacterClass) {
        self.characterClass = characterClass

        self._viewModel = ObservedObject(initialValue: GridViewModel(characterClass: characterClass, loadType: .fromDefault))
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

                        TalentGridView(viewModel: viewModel, selectedTalentId: $selectedTalentId, selectedBranchIndex: selectedTab)
                            .padding(.horizontal)

                        if showDescription {
                            descriptionView
                                .padding([.bottom, .horizontal])
                        }

                        TabbarButtonView(talentTrees: characterClass.talentsBranches, selectedTab: $selectedTab)
                            .shadow(color: Color(characterClass.nameColor).opacity(10), radius: 5, x: 0, y: 0)
                            .padding(.horizontal)
                    }

                    .onChange(of: selectedTalentId) {
                        showDescription = true
                    }
                } else {
                    Text("Выбранная вкладка недоступна")
                        .ignoresSafeArea()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
//                        if viewModel.pointsLeft == 51 {
//                            showErrorAlert.toggle()
//                        } else {
//                            showSaveSheet.toggle()
//                        }
//                        viewModel.saveDataToFile(data: viewModel.talentsBranches, filename: filename)
//                        print(filename)
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
                        viewModel.resetTalents()
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
            .alert("Save Build", isPresented: $showSaveSheet) {
                TextField("Enter name", text: $textfieldInput)
                Button("Cancel", role: .cancel) {}
                Button("Save Build", action: {
                    if textfieldInput.isEmpty {
                        showErrorAlert = true
                    } else {
                        filename = textfieldInput
//                        viewModel.saveDataToFile(data: viewModel.talentsBranches, filename: filename)
                        print(filename)
                        filename = ""
                    }
                })
                .foregroundStyle(.green)
            } message: {
                Text("Please enter the name for your build")
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                if viewModel.pointsLeft == 51 {
                    Text("The build cannot be empty.")
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
            Image(characterClass.iconName)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color(characterClass.nameColor), lineWidth: 2)
                }

            Text(characterClass.name)
                .foregroundStyle(Color(characterClass.nameColor))
            Text("(\(viewModel.branchPointAsString()))")

            Spacer()
            Text("Points left: \(viewModel.pointsLeft)")
        }
        .font(.headline)
        .fontWeight(.bold)
        .foregroundStyle(.accent)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(characterClass.nameColor, lineWidth: 2)
        }
        .shadow(color: Color(characterClass.nameColor).opacity(0.5), radius: 5, x: 0, y: 0)
    }

    private var descriptionView: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.showTalentName(for: selectedTalentId))
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("Rank: \(viewModel.showTalentRank(for: selectedTalentId))")
                        .foregroundStyle(.secondary)
                }
                .padding(.leading)
                Spacer()
            }
            Text(viewModel.showDescription(for: selectedTalentId))
                .padding(.horizontal)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(alignment: .topTrailing) {
            Button {
                if viewModel.tapCount > 1 {
                    viewModel.tapCount = 0
                }
                showDescription = false
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
    TalentsTreeView(characterClass: CharacterData.characterClasses[2])
}
