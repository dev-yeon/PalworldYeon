import SwiftUI


struct MatingView: View {
    
    @StateObject private var viewModel = PalViewModel() // PalViewModel 인스턴스를 관리하는 @StateObject
    @State private var selectedChildPalId: Int? // 선택된 자식 'Pal'의 ID를 저장하는 상태
    @State private var searchText = "" // 검색어를 저장하는 상태
    
    // 검색어에 따라 필터링된 'Pals' 목록을 반환하는 계산 속성
    var filteredPals: [Pal] {
        if searchText.isEmpty {
            return viewModel.pals
        } else {
//            return viewModel.pals.filter  { $0.name.lowercased().contains(searchText.lowercased())
            return viewModel.pals.filter { $0.name.lowercased().hasPrefix(searchText.lowercased())
            }
        }
    }
    
    var body: some View { // 'some View'를 반환 타입으로 명시적으로 선언
        VStack {
            // 검색창 UI
            TextField("Search...", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            List(filteredPals) { pal in
                HStack{
                    Text("No. \(pal.palDeckNo)")
                        .padding(3)
                    Image("palicon_\(pal.palDeckNo)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text(pal.name).tag(pal.id as Int?)
                        .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
               
                }
                
            }

            if let selectedChildId = selectedChildPalId,
               let selectedChild = viewModel.pals.first(where: { $0.id == selectedChildId }) {
                Text("Selected Child: \(selectedChild.name)")
            }
            
            // 부모 'Pals' 가져오기
            List {

            }
        }
        .onAppear {
            viewModel.loadPalsData() // 뷰가 나타날 때 'Pals' 데이터를 로드함
        }
    }
}
