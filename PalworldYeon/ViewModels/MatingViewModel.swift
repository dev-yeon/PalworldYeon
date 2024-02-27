//
//  MatingViewModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/27/24.
//

import Foundation
import Combine

class MatingViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [String] = [] // 예시 결과를 저장할 배열

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchText
            .removeDuplicates() // 연속적인 중복 입력 제거
            .debounce(for: 1.0, scheduler: RunLoop.main) // 사용자 입력 후 1초 대기
            .sink { [weak self] text in
                self?.search(query: text) // 쿼리 실행
            }
            .store(in: &cancellables)
    }

    func search(query: String) {
        // 데이터베이스 또는 API로부터 데이터 조회를 여기서 수행
        // 이 예시에서는 단순히 입력된 텍스트를 결과 배열에 추가하는 것으로 대체
        DispatchQueue.main.async {
            self.results.append(query)
        }
    }
}
