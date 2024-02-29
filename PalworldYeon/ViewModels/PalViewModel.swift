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

    @Published var breedingPairs: [BreedingPair] = []
    init() {
        loadPalsData()
        loadBreedingData()
    }
    struct BreedingData: Codable {
        let breedingPairs: [String: String]

        // 커스텀 init을 사용하여 직접 디코딩하지 않아도 되므로, 생략 가능
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

//    func loadPalBreedingData() {
//           guard let url = Bundle.main.url(forResource: "palBreedingData", withExtension: "json") else {
//               print("Failed to locate PalBreedingData.json in bundle.")
//               return
//           }
//
//        do {
//                   let data = try Data(contentsOf: url)
//                   let decoder = JSONDecoder()
//                   // JSON 파일의 최상위 구조가 배열이므로, 이에 맞게 디코딩 타입을 배열로 변경합니다.
//                   // [String: [String: String]] 구조를 가진 배열로 디코딩합니다.
//            self.breedingPairs = try decoder.decode([BreedingPair].self, from: data)
//               } catch {
//                   print("Failed to load PalBreedingData.json from bundle: \(error)")
//               }
//
//       }
    // JSON 파일 로드 및 파싱 함수
    func loadBreedingData() -> [[String: String]]? {
        guard let url = Bundle.main.url(forResource: "palBreedingData", withExtension: "json") else {
            print("Failed to locate palBreedingData.json in bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([[String: String]].self, from: data) // 배열로 디코딩 시도
            return decodedData
        } catch {
            print("Failed to load palBreedingData.json from bundle: \(error).......")
            return nil
        }
    }


    // String -> Int 변환
    func convertStringIdToInt(_ id: String) -> Int? {
        return Int(id)
    }

    // Int -> String 변환
    func convertIntIdToString(_ id: Int) -> String {
        return String(id)
    }
}


//extension PalViewModel {
//    func determineParents(forChildId childId: Int?) -> [Pal] {
//        guard let childId = childId else {
//            return []
//        }
//        
//        // Here you would implement the logic to determine parents based on the childId
//        // For example, you can filter the list of Pal objects to find those with matching parent IDs
//        
//        var parents: [Pal] = []
//        for pal in pals {
//            if pal.parents.contains(childId) {
//                parents.append(pal)
//            }
//        }
//        
//        return parents
//    }
//}
