//
//  BreedingViewModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/29/24.
//

import Foundation
import Combine

class BreedingViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredBreedingPairs: [BreedingPair] = []
    
    var allBreedingPairs: [BreedingPair] = [] // 모든 교배 데이터를 저장하는 배열
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // 검색어가 변경될 때마다 filteredBreedingPairs 업데이트
        $searchText
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterBreedingPairs(with: text)
            }
            .store(in: &cancellables)
    }
    
    func filterBreedingPairs(with text: String) {
        if text.isEmpty {
            filteredBreedingPairs = allBreedingPairs
        } else {
            filteredBreedingPairs = allBreedingPairs.filter { pair in
                // 교배 목록 필터링 로직
               pair.name.lowercased().contains(text.lowercased())
            }
        }
    }
}
