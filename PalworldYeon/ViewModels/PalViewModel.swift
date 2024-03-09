//
//  ViewController.swift
//  PalworldYeon
//
//  Created by yeon on 2/16/24.
//
import Foundation


class PalViewModel: ObservableObject {
    @Published var pals: [Pal] = []
    @Published var searchNumber: Int?
//    @Published var breedingPairs: [BreedingData.BreedingPair] = []
    
    init() {
        loadPalsData()

//        BreedingViewModel.loadBreedingData()
    }
    func loadPalsData() {
        guard let url = Bundle.main.url(forResource: "palData", withExtension: "json") else {
            print("Failed to locate palData.json in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            self.pals = try JSONDecoder().decode([Pal].self, from: data)
        } catch {
            print("Failed to load palData.json from bundle: \(error)")
        }
    }

    
    //MARK: - 주어진 ID로 Pal 이름을 찾는 함수
    func findingPalName(forId id: Int)-> String? {
        return pals.first(where: { $0.id == id })?.name
    }
    func filterBreedingPairs(with text: String) {
        print("Filtering with text: \(text)")
        // 필터링 로직
    }

}
// 기존 변환 함수들은 유지
extension PalViewModel {
    func convertStringIdToInt(_ id: String) -> Int? {
        return Int(id)
    }

    func convertIntIdToString(_ id: Int) -> String {
        return String(id)
    }
}

