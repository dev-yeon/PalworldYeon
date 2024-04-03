//
//  ParentsSheetView.swift
//  PalworldYeon
//
//  Created by yeon on 3/11/24.
//

import SwiftUI

struct ParentsSheetView: View {
    @EnvironmentObject var palManager: PalManager

    var parents: [Pal]
    var searchViewModel = SearchFieldViewModel()
    var selectedOneChildName: String // 선택된 자식 Pal의 이름
    //    @ObservedObject var breedingViewModel = BreedingViewModel()
    // 뷰가 나타날 때 부모 펠 쌍을 찾는 동작을 수행
    private func findParents() {
        palManager.findParentPairs(forChildName: selectedOneChildName)
    }
    //  아빠의 ID로 이름을 찾는 함수
    private func findFatherNameById(_ id: Int) -> String {
        if let father = palManager.pals.first(where: { $0.id == id }) {
            return father.name
        } else {
            return "Unknown"
        }
    }

    var body: some View {
        NavigationView {
            List {
                // 부모 펠 리스트를 섹션별로 나누어 표시
                Section(header: Text("\(selectedOneChildName)의 가능한 부모 조합")) {
                    ForEach(Array(palManager.parentPals.enumerated()), id: \.offset) { index, parent in
                        ParentRow(parent: parent)
                    }
                }
            }
            .navigationBarTitle("\(selectedOneChildName)의 가능한 부모", displayMode: .inline)
        }
        .onAppear(perform: {
            // 뷰가 나타나면 선택된 자식의 이름으로 부모 펠 쌍을 찾는 동작을 수행
            self.palManager.findParentPairs(forChildName: selectedOneChildName)
        })
    }
}

    // 부모 펠의 정보를 표시하는 Row 뷰
    struct ParentRow: View {
        var parent: Pal

        var body: some View {
            HStack {
                Image(systemName: "person.fill") // 예시 이미지, 실제 앱에서는 부모 펠의 이미지를 사용
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(parent.name) // 부모 펠의 이름 표시
            }
        }

        // 아빠의 ID로 이름을 찾는 함수
//        func findFatherNameById(_ id: Int) -> String {
//            if let father = palManager.pals.first(where: { $0.id == id }) {
//                return father.name
//            } else {
//                return "알 수 없음"
//            }
//        }
    }


//
//    var filteredBreedingData: [BreedingData] {
//        palManager.allBreedingData.filter { breedingData in
//            let matchingPairs = breedingData.breedings.filter { $0.childName.lowercased() == selectedOneChildName.lowercased() }
//                    return !matchingPairs.isEmpty
//        }
//    }
//
//    var body: some View {
//           NavigationView {
//               List {
//                   // `BreedingData`가 `Hashable`을 준수하므로, `id: \.self` 사용 가능
//                   ForEach(filteredBreedingData, id: \.self) { breedingData in
//                       Section(header: Text("\(selectedOneChildName)의 가능한 부모 조합")) {
//                           ForEach(breedingData.breedings, id: \.fatherid) { pair in
//                               HStack {
//                                   VStack(alignment: .leading) {
//                                       Text("엄마: \(breedingData.motherName)")
//                                       // 아빠를 id로 찾아 이름을 표시, 찾지 못할 경우 "알 수 없음" 표시
//                                       Text("아빠: \(self.findFatherNameById(pair.fatherid))")
//                                   }
//                                   Spacer()
//                                   Image(systemName: "heart.fill") // 사랑을 상징하는 아이콘으로 부모 조합을 나타냄
//                                       .foregroundColor(.red)
//                                       .frame(width: 50, height: 50)
//                               }
//                           }
//                       }
//                   }
//               }
//               .navigationBarTitle("\(selectedOneChildName)의 가능한 부모", displayMode: .inline)
//           }
//       }
//    var body: some View {
//           NavigationView {
//               List(palManager.parentPals, id: \.id) { parent in
//                   HStack {
//                       Image(systemName: "person.fill")
//                           .resizable()
//                           .scaledToFit()
//                           .frame(width: 50, height: 50)
//                       Text(parent.name)
//                   }
//               }
//               .navigationBarTitle("\(selectedOneChildName)의 가능한 부모", displayMode: .inline)
//           }
//           .onAppear(perform: findParents) // 뷰가 나타나면 부모 펠 찾기 실행
//       }
