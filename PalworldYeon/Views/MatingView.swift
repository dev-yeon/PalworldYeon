import SwiftUI
import Combine

struct MatingView: View {
    @StateObject private var searchFieldViewModel = SearchFieldViewModel()
    @StateObject private var breedingViewModel = BreedingViewModel()
    @StateObject private var viewModel = PalViewModel() // PalViewModel 인스턴스를 관리하는 @StateObject
    @State private var selectedChildPalId: Int?
    @State private var selectedChildPalName: String? // 선택된 자식 'Pal'의 ID를 저장하는 상태
    @State private var searchText = "" // 검색어를 저장하는 상태
    //도로롱
    // 검색어에 따라 필터링된 'Pals' 목록을 반환하는 계산 속성
    var filteredPals: [Pal] {
        if searchText.isEmpty {
            return viewModel.pals
        } else {
            return viewModel.pals.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        //MARK: -검색창
        VStack {
            TextField("찾고 싶은 자식 펠의 이름 입력 ex)도로롱 '도'", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            List(filteredPals) { pal in
                Button(action: {
                    // 선택된 Pal의 이름을 저장
                    self.selectedChildPalName = pal.name
                    // 선택된 Pal의 이름을 바탕으로 해당 Pal의 id를 찾아 selectedChildPalId를 업데이트
                    if let selectedPal = viewModel.pals.first(where: { $0.name == self.selectedChildPalName }) {
                        self.selectedChildPalId = selectedPal.id
                    }
                }) {
                    HStack {
                        Text("No. \(pal.palDeckNo)")
                            .padding(3)
                        Image("palicon_\(pal.palDeckNo)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text(pal.name)
                            .lineSpacing(10.0)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            
            // 선택된 자식 이름이 있고, 그에 따른 부모 쌍의 검색 결과를 표시합니다.
            if let selectedChildName = selectedChildPalName {
                Text("Selected Child: \(selectedChildName)")
                    .padding()
                
                // 검색 결과 표시
                ForEach(breedingViewModel.results, id: \.self) { result in
                    Text(result)
                }
            }
        }
        
        
        .onAppear {
            viewModel.loadPalsData()
            breedingViewModel.loadBreedingData() // 교배 데이터도 로드합니다.
        }
        // selectedChildPalName 값이 변경될 때마다 부모 쌍을 검색합니다.
        .onChange(of: selectedChildPalName) { newValue in
            if let newChildName = newValue {
                breedingViewModel.findParentPairs(forChildName: newChildName)
            }
        }
    }
}

