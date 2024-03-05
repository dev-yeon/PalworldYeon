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
//    @Published var breedingPairs: [BreedingPair] = []

    init() {
        loadPalsData()
        loadBreedingData()
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
    // JSON 파일 로드 및 파싱 함수 수정
    func loadBreedingData() {
        guard let url = Bundle.main.url(forResource: "palBreedingData", withExtension: "json") else {
            print("Failed to locate palBreedingData.json in bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // 가정한 구조에 따라 디코딩
            let decodedBreedingData = try decoder.decode([BreedingData].self, from: data)
            // decodedBreedingData를 사용하여 필요한 작업 수행
            // 예: breedingPairs 업데이트
        } catch {
            print("Failed to load palBreedingData.json from bundle: \(error)...BreedingData")
        }
    }

    struct BreedingData: Codable {
        let breedingPairs: [String: String] // 실제 JSON 구조에 따라 타입 조정 필요
    }

    // 기존의 변환 함수들은 유지
    func convertStringIdToInt(_ id: String) -> Int? {
        return Int(id)
    }

    func convertIntIdToString(_ id: Int) -> String {
        return String(id)
    }
}

//class PalViewModel: ObservableObject {
//    @Published var pals: [Pal] = []
//    @Published var searchNumber: Int?
//
//    @Published var breedingPairs: [BreedingPair] = []
//    init() {
//        loadPalsData()
//        loadBreedingData()
//    }
//    struct BreedingData: Codable {
//        let breedingPairs: [String : String]
//
//        // 커스텀 init을 사용하여 직접 디코딩하지 않아도 되므로, 생략 가능
//    }
//
//    func loadPalsData() {
//        guard let url = Bundle.main.url(forResource: "palData", withExtension: "json") else {
//            print("Failed to locate palData.json in bundle.")
//            return
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            self.pals = try JSONDecoder().decode([Pal].self, from: data)
//        } catch {
//            print("Failed to load palData.json from bundle: \(error)")
//        }
//    }
//
//    // JSON 파일 로드 및 파싱 함수
//    func loadBreedingData() -> [[String: String]]? {
//        guard let url = Bundle.main.url(forResource: "palBreedingData", withExtension: "json") else {
//            
//            print("Failed to locate palBreedingData.json in bundle.")
//            return nil
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            var decodedBreedingData = try decoder.decode([[String: String]].self, from: data) // 배열로 디코딩 시도
//       
//            decodedBreedingData.removeFirst() // 첫 번째 요소 제거
//            return decodedBreedingData
//        } catch {
//            
//            print("Failed to load palBreedingData.json from bundle: \(error).......")
//            
//            return nil
//        }
//    }
//
//
//    // String -> Int 변환
//    func convertStringIdToInt(_ id: String) -> Int? {
//        return Int(id)
//    }
//
//    // Int -> String 변환
//    func convertIntIdToString(_ id: Int) -> String {
//        return String(id)
//    }
//}
//
