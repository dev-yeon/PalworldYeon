//
//  ParentsSheetView.swift
//  PalworldYeon
//
//  Created by yeon on 3/11/24.
//

import SwiftUI

struct ParentsSheetView: View {
    @EnvironmentObject var palManager: PalManager
    var selectedOneChildName: String

    var parents: [Pal]
    var searchViewModel = SearchFieldViewModel()

    private func findParents() {
        palManager.findParentPairs(forChildName: selectedOneChildName)
    }
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("\(selectedOneChildName)의 가능한 부모 조합")
                            .font(.headline)
                            .padding(.vertical, 4)
                ) {
                    ForEach(palManager.parentPairs.indices, id: \.self) { index in
                        let pair = palManager.parentPairs[index]
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("No. \(pair.mother.palDeckNo)")
                                    .padding(3)
                                Image("palicon_\(pair.mother.palDeckNo)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text(pair.mother.name)
                                    .lineSpacing(10.0)
                            }
                            .font(.subheadline)
                            .padding(.vertical, 2)
                            HStack {
                                Text("No. \(pair.father.palDeckNo)")
                                    .padding(3)
                                Image("palicon_\(pair.father.palDeckNo)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text(pair.father.name)
                                    .lineSpacing(10.0)
                            }
                                .font(.subheadline)
                                .padding(.vertical, 2)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
//            .navigationBarTitle("\(selectedOneChildName)의 가능한 부모", displayMode: .inline)
//            
            .onAppear {
                self.palManager.findParentPairs(forChildName: selectedOneChildName)
            }
        }
    }
}
