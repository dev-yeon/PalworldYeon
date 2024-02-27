//
//  PalBreedingAnalyzer.swift
//  PalworldYeon
//
//  Created by yeon on 2/27/24.
//

import Foundation

// Pal 구조체

// JSON 파일로부터 부모-자식 관계를 파싱하는 함수
func parsePalBreedingData(from jsonData: Data) -> [Int: [Pal]] {
    let childToParentsMap = [Int: [Pal]]()

    do {
        let decoder = JSONDecoder()
        _ = try decoder.decode([String: Pal].self, from: jsonData)
        
        // 이제 palData 딕셔너리를 사용하여 자식 ID와 부모 Pal 인스턴스를 매핑합니다.
        // 예제 코드에서는 실제 JSON 데이터 구조와 매핑 방법에 따라 다를 수 있습니다.
    } catch {
        print("Error parsing JSON: \(error)")
    }

    return childToParentsMap
}

// 자식 Pal의 ID를 받아 부모 Pal 인스턴스들을 반환하는 함수
func findParents(forChildId childId: Int, in childToParentsMap: [Int: [Pal]]) -> [Pal] {
    return childToParentsMap[childId] ?? []
}
func parsePalBreedingData(from jsonData: Data) -> [Int: [Int]] {
    var childToParentsMap = [Int: [Int]]()

    do {
        if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            for (key, value) in jsonDict where key != "Search:" {
                if let childId = Int(key), let parentName = value as? String {
                    // 예시에서는 부모의 이름만 주어지므로, 여기서는 단순히 이름을 기준으로 ID를 매핑합니다.
                    // 실제로는 부모의 ID를 정확히 알아내는 추가 로직이 필요할 수 있습니다.
                    let parentId = findPalIdByName(parentName, in: jsonDict)
                    if childToParentsMap[childId] == nil {
                        childToParentsMap[childId] = [parentId]
                    } else {
                        childToParentsMap[childId]?.append(parentId)
                    }
                }
            }
        }
    } catch {
        print("Error parsing JSON: \(error)")
    }

    return childToParentsMap
}

// 이름으로 Pal의 ID를 찾는 함수 (단순화된 예시)
func findPalIdByName(_ name: String, in jsonDict: [String: Any]) -> Int {
    if let key = jsonDict.first(where: { $0.value as? String == name })?.key {
        return Int(key) ?? -1
    }
    return -1
}


// 자식 Pal의 ID를 받아 부모 Pal의 ID들을 반환하는 함수
func findParents(forChildId childId: Int, in childToParentsMap: [Int: [Int]]) -> [Int] {
    return childToParentsMap[childId] ?? []
}
