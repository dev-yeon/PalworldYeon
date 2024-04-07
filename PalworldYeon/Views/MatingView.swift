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

                Button("부모 찾기") {
                    if let selectedChildName = selectedChildName {
                        palManager.loadBreedingData {
                            self.palManager.findParentPairs(forChildName: selectedChildName)
                            self.showParentSheet = true
                        }
                    }
                }
            }
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
            // 조건부로 ParentsSheetView 표시
            if showParentSheet, let selectedChildName = selectedChildName {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showParentSheet = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.headline) // 아이콘 크기 조정
                                .padding(10) // 패딩을 줄여서 전체 크기 축소
                                .foregroundColor(.white) // 아이콘 색상 변경 (선택적)
                                .background(Color.black.opacity(0.6)) // 배경색 변경 및 투명도 조정
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 1) // 외곽선 추가 (선택적)
                                )
                        }
                        .padding(.trailing, 20) // 버튼이 HStack 오른쪽 끝에서 너무 멀지 않도록 조정
                        .padding(.top, 5) // 상단 여백 조정으로 위치 조정
                    
                    }
                    .padding(.trailing)
                    ParentsSheetView(selectedOneChildName: selectedChildName, parents: palManager.parentPals)
                        .environmentObject(palManager)
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

        // selectedChildPalName 값이 변경될 때마다 부모 쌍을 검색합니다.
        .onChange(of: selectedChildName) { newValue in
            if let newChildName = newValue {
                palManager.findParentPairs(forChildName: newChildName)
                self.showParentSheet = true
            }
        }
//        .sheet(isPresented: $showParentSheet) {
//            if let selectedChildName = selectedChildName {
//                ParentsSheetView(selectedOneChildName: selectedChildName, parents: palManager.parentPals)
//                    .environmentObject(palManager) // `palManager` 인스턴스를 전달합니다.
//            }
//        }
    }
}
