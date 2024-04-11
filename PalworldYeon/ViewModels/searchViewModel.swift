//
//  searchViewModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/29/24.
//

import Foundation
import Combine


class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [String] = []

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchText
            .removeDuplicates()
            .debounce(for: 1.0, scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.search(query: text)
                
            }
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        DispatchQueue.main.async {
            self.results.append(query)
        }
    }
}
