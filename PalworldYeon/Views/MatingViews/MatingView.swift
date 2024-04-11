import SwiftUI
import Combine

struct MatingView: View {

    @StateObject private var palManager = PalManager()
    @StateObject private var searchFieldViewModel = SearchFieldViewModel()

    @StateObject private var matingViewModel = PalViewModel()

    @State private var selectedChildPalId: Int?
    @State private var selectedChildName: String?
    @State private var searchChildName = ""
    @State private var showParentSheet = false
    @State private var loadBreedingData = false

    //MARK: 검색어에 따라 필터링된 'Pals' 목록을 반환하는 계산 속성
    var filteredPals: [Pal] {
        palManager.pals.filter {
            searchChildName.isEmpty || $0.name.lowercased().hasPrefix(searchChildName.lowercased())
        }
    }
    var body: some View {
        // MARK: - 검색창
        VStack {
            HStack{
                TextField("찾고 싶은 자식 펠의 이름 입력", text: $searchChildName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            Spacer()
                            if !searchChildName.isEmpty {
                                Button(action: {
                                    self.searchChildName = ""
                                    self.showParentSheet = false
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 20))
                                        .padding(.vertical)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.trailing, 40)
                            }
                        }
//                        .padding(.horizontal, 5)
                    )
            }
            .disabled(selectedChildName == nil)
            if filteredPals.isEmpty {
                Spacer()
                EmptyMatingView()
                Spacer()
            } else {
                //MARK: - 팔들의 목록 (버튼화)
                List(filteredPals, id: \.id) { pal in
                    Button(action: {
                        self.selectedChildName = pal.name
                        self.searchChildName = pal.name // 검색창 자동 채우기
                        if let selectedChildPal = self.palManager.pals.first(where: { $0.name == pal.name }) {
                            self.selectedChildPalId = selectedChildPal.id
                        }
                        self.showParentSheet = true
                    }) {
                        PalRowView(pal: pal)
                            .background(self.selectedChildPalId == pal.id ? Color.blue.opacity(0.2) : Color.clear) // 선택된 항목 배경색 변경
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            if showParentSheet, let selectedChildName = selectedChildName {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showParentSheet = false
                            self.searchChildName = ""
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20))
                                .padding(8)
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 5)
                    }
                    .padding(.trailing)
                    ParentsSheetView(selectedOneChildName: selectedChildName, parents: palManager.parentPals)
                        .frame(height: 500)
                        .environmentObject(palManager)
                }
            }
        }
        .onAppear {
            palManager.loadPalsData(){
                DispatchQueue.main.async {
                  }
              }
            palManager.loadBreedingData() {
            }
        }
        .onChange(of: selectedChildName) { newValue in
            if let newChildName = newValue {
                palManager.findParentPairs(forChildName: newChildName)
                self.showParentSheet = true
            }
        }
    }
}


