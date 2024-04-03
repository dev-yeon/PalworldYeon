import SwiftUI
import Combine

struct MatingView: View {
    // PalManager를 @StateObject로 선언하여 뷰와 연결
    @StateObject private var palManager = PalManager()
    @StateObject private var searchFieldViewModel = SearchFieldViewModel()
//    @StateObject private var breedingViewModel = BreedingViewModel()
    @StateObject private var matingViewModel = PalViewModel()

    @State private var selectedChildPalId: Int?
    @State private var selectedChildName: String? // 선택된 자식 'Pal'의 Name를 저장하는 상태
    @State private var searchChildName = "" // 검색어를 저장하는 상태
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

                Button("부모 찾기") {
                    if let selectedChildName = selectedChildName {
                        palManager.loadBreedingData {
                            self.palManager.findParentPairs(forChildName: selectedChildName)
                            self.showParentSheet = true
                        }
                    }
                }
            }
            //도로롱
            .disabled(selectedChildName == nil)

            if filteredPals.isEmpty {
                EmptyMatingView()

            } else {
                //MARK: - 팔들의 목록 (버튼화)
                List(filteredPals, id: \.id) { pal in
                    Button(action: {
                        // 선택된 Pal의 이름을 저장
                        self.selectedChildName = pal.name
                        // 선택된 Pal의 이름을 바탕으로 해당 Pal의 id를 찾아 selectedChildPalId를 업데이트
                        if let selectedChildPal = self.palManager.pals.first(where: { $0.name == pal.name }) {
                            self.selectedChildPalId = selectedChildPal.id
                        }
                        // Sheet를 표시하기 위해 showParentSheet를 true로 설정
                                       self.showParentSheet = true
        
                    }) {
                        PalRowView(pal: pal) // PalRowView 사용
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .onAppear {
            print("Total Pals on Appear: \(palManager.pals.count)")
            palManager.loadPalsData()
            palManager.loadBreedingData() {
                // 데이터 로드 후 배열의 상태를 다시 출력하여 확인
                print("Total Pals after Data Load: \(self.palManager.pals.count)")
            }
        }

//        .onChange(of: searchChildName) { _ in
//            print("Filtered Pals on Search Change: \(self.filteredPals.map { $0.name })")
//        }
        // selectedChildPalName 값이 변경될 때마다 부모 쌍을 검색합니다.
        .onChange(of: selectedChildName) { newValue in
            if let newChildName = newValue {
                palManager.findParentPairs(forChildName: newChildName)
                self.showParentSheet = true
            }
        }
        .sheet(isPresented: $showParentSheet) {
            // 'parents' 인자로 'breedingViewModel.parentPals'을 전달하고,
            // 'selectedOneChildName' 인자로는 'selectedChildName'을 옵셔널 바인딩을 통해 안전하게 전달합니다.
            // PalManager 인스턴스를 올바르게 전달합니다.
            if let selectedChildName = selectedChildName {
                ParentsSheetView(parents: palManager.parentPals, selectedOneChildName: selectedChildName)
                    .environmentObject(palManager) // `palManager` 인스턴스를 전달합니다.
            }
        }
    }
}
//            ParentsSheetView(parents: palManager.parentPals, searchViewModel: searchFieldViewModel,selectedOneChildName: selectedChildName ?? "")
//        .environmentObject(palManager)
