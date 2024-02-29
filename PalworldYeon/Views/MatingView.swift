import SwiftUI
import Combine

struct MatingView: View {
    @StateObject private var matingViewModel = MatingViewModel()
    @StateObject private var viewModel = PalViewModel() // PalViewModel 인스턴스를 관리하는 @StateObject
    @State private var selectedChildPalId: Int? // 선택된 자식 'Pal'의 ID를 저장하는 상태
    @State private var searchText = "" // 검색어를 저장하는 상태
    
    // 검색어에 따라 필터링된 'Pals' 목록을 반환하는 계산 속성
    var filteredPals: [Pal] {
        if searchText.isEmpty {
            return viewModel.pals
        } else {
            
            return viewModel.pals.filter { $0.name.lowercased().hasPrefix(searchText.lowercased())
            }
        }
    }
    
    var body: some View { // 'some View'를 반환 타입으로 명시적으로 선언
        VStack {
            // 검색창 UI
            TextField("찾고 싶은 자식 펠의 이름 입력 ex)도로롱 '도'", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            List(filteredPals) { pal in
                Button(action: {
                    self.selectedChildPalId = pal.id
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
                .buttonStyle(PlainButtonStyle()) // 버튼의 스타일을 제거하여 기본 List 스타일 유지
            }
            // 조건부 뷰는 VStack 외부에서 바로 사용
                      if let selectedChildId = selectedChildPalId,
                         let selectedChild = viewModel.pals.first(where: { $0.id == selectedChildId }) {
                          Text("Selected Child: \(selectedChild.name)")
                          // 교배 가능한 조합을 로드하고 표시하는 로직 필요
                      }
                  }
                  .onAppear {
                      viewModel.loadPalsData()
                  }
              }
          }
