//
//  LoadingTalentView.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 05/06/2024.
//

import SwiftUI

struct LoadingTalentView: View {
    @State private var listOfBuilds: [String] = []

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
                    List(listOfBuilds, id: \.self) { file in
                        Text(file)
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.ultraThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.horizontal)
                    }
                    .scrollContentBackground(.hidden)

                    Spacer()
                }
            }
//            .onAppear(perform: loadListOfBuilds)
        }
    }

    func loadListOfBuilds() {
//        listOfBuilds = getListOfSavedFiles()
    }

    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func getListOfSavedFiles() -> [String] {
        do {
            let documentsURL = getDocumentsDirectory()
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)

            return fileURLs.filter { $0.pathExtension == "json" }.map { $0.lastPathComponent }
        } catch {
            print("Error while enumerating files \(getDocumentsDirectory().path): \(error.localizedDescription)")
            return []
        }
    }
}

#Preview {
    LoadingTalentView()
}
