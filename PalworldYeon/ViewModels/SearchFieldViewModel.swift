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
    @Published var filteredPals: [Pal] = [] 
    
    private var allPals: [Pal] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchText
            .removeDuplicates()
            .debounce(for: 1.0, scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterPals(with: text)
            }
            .store(in: &cancellables)
    }

    func filterPals(with query: String) {
        DispatchQueue.main.async {
            if query.isEmpty {
                self.filteredPals = self.allPals
            } else {
                self.filteredPals = self.allPals.filter { pal in
                    return pal.name.contains(query)
                }
            }
        }
    }
}
