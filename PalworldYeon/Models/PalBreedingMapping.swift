//
//  PalBreedingMapping.swift
//  PalworldYeon
//
//  Created by yeon on 2/27/24.
//
//
import Foundation
import Combine
//MARK: - JSON 파일에서 사용할 수 있는 모델 정의



//MARK: - JSON 파일 로드 및 파싱 함수

func loadBreedingData(from filename: String) -> [String: String]? {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        print("Failed to locate \(filename).json in bundle.")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode([String: String].self, from: data) // 배열 내의 첫 번째 객체로 예상되는 구조에 대해 디코딩
        return decodedData
    } catch {
        print("Failed to load \(filename).json from bundle: \(error)....PalBreedingMapping")
        return nil
    }
}
//MARK: - 이름을 사용하여 아이디 찾기

//주어진 name 문자열과 일치하는 name을 가진 Pal 객체를 pals 배열에서 찾고, 해당 객체의 id를 반환
//pals 배열을 순회하면서 주어진 name과 일치하는 name 속성을 가진 첫 번째 Pal 객체를 찾습니다.
//찾은 Pal 객체의 id를 반환합니다.
//만약 해당 이름을 가진 Pal 객체가 배열 내에 없으면 nil을 반환합니다.
func findPalIdByName(name: String, pals: [Pal]) -> Int? {
    return pals.first(where: { $0.name == name })?.id
}
//MARK: - 자식 Pal의 palDeckNum을 통해 가능한 부모 쌍을 찾는 함수

func findPossibleParents(childDeckNum: String, palData: [String: [String: String]]) -> [(parent1DeckNum: String, parent2DeckNum: String)] {
    var possibleParents: [(String, String)] = []

    for (parent1DeckNum, children) in palData {
        for (parent2DeckNum, childName) in children {
            if childName == childDeckNum {
                possibleParents.append((parent1DeckNum, parent2DeckNum))
            }
        }
    }

    return possibleParents
}
