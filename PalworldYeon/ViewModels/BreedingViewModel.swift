//
//  BreedingViewModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/29/24.
//도로로

import Foundation
import Combine

class BreedingViewModel: ObservableObject {
    @Published var results: [String] = []
    var allBreedingData: [BreedingData] = []

    func findParentPairs(forChildName childName: String) {
        var searchResults: [String] = []

        for breedingData in allBreedingData {
            for pair in breedingData.breedings where pair.childName.lowercased() == childName.lowercased() {
     
                let result = "\(breedingData.motherName) - \(pair.fatherid)"
                searchResults.append(result)
            }
        }
        
        DispatchQueue.main.async {
            self.results = searchResults
        }
    }
    
    // JSON 파일 로드 및 파싱 함수 수정
    func loadBreedingData() {
        guard let url = Bundle.main.url(forResource: "new_palBreedingData", withExtension: "json") else {
            print("Failed to locate new_palBreedingData.json in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // JSON 파일로부터 BreedingData 배열을 디코딩합니다.
            let decodedBreedingDataArray = try decoder.decode([BreedingData].self, from: data)
            // 디코드된 데이터를 allBreedingData에 할당합니다.
            DispatchQueue.main.async {
                self.allBreedingData = decodedBreedingDataArray
            }
        } catch {
            print("Failed to load new_palBreedingData.json from bundle: \(error)")
        }
    }
}
//class BreedingViewModel: ObservableObject {
//    @Published var searchText = ""
//    @Published var filteredBreedingPairs: [BreedingPair] = []
//    
//    var allBreedingPairs: [BreedingPair] = [] // 모든 교배 데이터를 저장하는 배열
//    private var cancellables: Set<AnyCancellable> = []
//    
//    init() {
//        // 검색어가 변경될 때마다 filteredBreedingPairs 업데이트
//        $searchText
//            .removeDuplicates()
//            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
//            .sink { [weak self] text in
//                self?.filterBreedingPairs(with: text)
//            }
//            .store(in: &cancellables)
//    }
//    
//    func filterBreedingPairs(with text: String) {
//        if text.isEmpty {
//            filteredBreedingPairs = allBreedingPairs
//        } else {
//            filteredBreedingPairs = allBreedingPairs.filter { pair in
//                // 교배 목록 필터링 로직
//               pair.childName.lowercased().contains(text.lowercased())
//            }
//        }
//    }
//}
