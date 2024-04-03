//
//  MatingViewModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/27/24.
//

import Foundation
import Combine

class
SearchFieldViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredPals: [Pal] = [] // 조건에 맞는 Pal 객체들을 저장할 배열
    
    private var allPals: [Pal] = [] // 모든 Pal 객체를 저장할 배열, 실제 데이터로 초기화 필요
    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchText
            .removeDuplicates() // 연속적인 중복 입력 제거
            .debounce(for: 1.0, scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterPals(with: text) // 쿼리 실행
            }
            .store(in: &cancellables)
    }

    func filterPals(with query: String) {
        DispatchQueue.main.async {
            if query.isEmpty {
                self.filteredPals = self.allPals
            } else {
                self.filteredPals = self.allPals.filter { pal in
                    // 여기서 검색 조건을 정의합니다.
                    // 예를 들어, Pal의 name이 query를 포함하는 경우를 필터링
                    return pal.name.contains(query)
                }
            }
        }
    }
}
