//
//  PalBreeding.swift
//  PalworldYeon
//
//  Created by yeon on 2/27/24.
//
//
import Foundation

// JSON 파일에서 사용할 수 있는 모델 정의
struct PalMapping: Codable {
    var palMappingData: [String: [String: String]]
}

// JSON 데이터를 디코딩하는 함수
func decodeJsonFromFile(fileName: String) -> PalMapping? {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("JSON 파일을 찾을 수 없습니다.")
        return nil
    }
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode(PalMapping.self, from: data)
        return jsonData
    } catch {
        print("JSON 데이터를 디코딩하는 동안 오류가 발생했습니다: \(error)")
        return nil
    }
}

// 부모 ID를 사용하여 자식 이름 찾기
func findChildName(parent1Id: String, parent2Id: String, palMapping: PalMapping) -> String? {
    if let childName = palMapping.palMappingData[parent1Id]?[parent2Id] {
        return childName
    } else {
        print("해당 부모 ID 조합으로 자식을 찾을 수 없습니다.")
        return nil
    }
}

// 예제 사용
//if let palMapping = decodeJsonFromFile(fileName: "palBreedingData") {
//    if let childName = findChildName(parent1Id: "1", parent2Id: "2", palMapping: palMapping) {
//        print("자식의 이름: \(childName)")
//    }
//}
