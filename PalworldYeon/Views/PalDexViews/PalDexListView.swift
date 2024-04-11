//
//  PalDexListView.swift
//  PalworldYeon
//
//  Created by yeon on 4/7/24.
//

import SwiftUI

struct PalDexListView: View {
    @EnvironmentObject var palManager: PalManager
    @State private var searchPalName = ""
    @State private var selectedPalId: Int?

    //MARK: 검색어에 따라 필터링된 'Pals' 목록을 반환하는 계산 속성
    var filteredPals: [Pal] {
        palManager.pals.filter {
            searchPalName.isEmpty || $0.name.lowercased().hasPrefix(searchPalName.lowercased())
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("찾고 싶은 자식 펠의 이름 입력", text: $searchPalName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Button("펠 찾기") {
                        if !searchPalName.isEmpty {
                            palManager.loadBreedingData {
                                self.palManager.findParentPairs(forChildName: searchPalName)
                            }
                        }
                    }
                }
                .disabled(searchPalName.isEmpty)

                List(filteredPals) { pal in
                    NavigationLink(destination: PalDetailView(pal: pal)) {
                        PalRowView(pal: pal)
                    }
                }
            }
            .navigationTitle("펠월드 도감")
        }
        .onAppear {
            if palManager.pals.isEmpty {
                palManager.loadPalsData() {
                    DispatchQueue.main.async {
                    }
                }
            }
        }
    }
}
