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
    @Published var results: [String] = [] // 예시 결과를 저장할 배열
    

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchText
            .removeDuplicates() // 연속적인 중복 입력 제거
            .debounce(for: 1.0, scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.search(query: text) // 쿼리 실행
            }
            .store(in: &cancellables)
    }

    func search(query: String) {
        
        DispatchQueue.main.async {
            self.results.append(query)
        }
    }
}
