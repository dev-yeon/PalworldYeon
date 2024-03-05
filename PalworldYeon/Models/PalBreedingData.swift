//
//  PalBreedingData.swift
//  PalworldYeon
//
//  Created by yeon on 3/1/24.
//
import Foundation


struct PalBreedingData: Decodable {
    var pairs: [Int: [Int: String]] = [:] // 교배 쌍을 저장하는 딕셔너리
    var searchId: Int? // "Search:" 키에 해당하는 값

    // 동적 키 처리를 위한 내부 구조체
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        // 문자열 키를 위한 초기화 메소드
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        // 숫자형 키를 위한 초기화 메소드
        init?(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }

    // 커스텀 디코더 초기화 메소드
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempPairs = [Int: [Int: String]]() // 임시 저장소
        var tempSearchId: Int? // 임시 Search ID

        // 컨테이너 내 모든 키를 순회하며 데이터 추출
        for key in container.allKeys {
            // "Search:" 키 처리
            if key.stringValue == "Search:", let searchId = try? container.decodeIfPresent(Int.self, forKey: key) {
                tempSearchId = searchId
            } else {
                // 교배 쌍 데이터 처리
                let nestedContainer = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: key)
                var childPairs = [Int: String]()
                for childKey in nestedContainer.allKeys {
                    // 숫자형 문자열 키를 Int로 변환하고, 값을 String으로 추출
                    let value = try nestedContainer.decode(String.self, forKey: childKey)
                    // 옵셔널 바인딩을 사용해 intValue가 nil이 아닌 경우만 처리
                    if let keyIntValue = key.intValue, let childKeyIntValue = childKey.intValue {
                        childPairs[childKeyIntValue] = value
                    }
                }
                // 변환된 키와 값을 최종 저장소에 할당
                if let keyIntValue = key.intValue {
                    tempPairs[keyIntValue] = childPairs
                }
            }
        }

        // 임시 저장소에서 최종 구조체 필드로 데이터 이전
        self.pairs = tempPairs
        self.searchId = tempSearchId
    }
}

//struct PalBreedingData: Decodable {
//    var pairs: [Int: [Int: String]] // 교배 쌍을 저장하는 딕셔너리
//    var searchId: Int? // "Search:" 키에 해당하는 값
//
//    private struct DynamicCodingKeys: CodingKey {
//        var stringValue: String
//        var intValue: Int?
//        
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//            self.intValue = nil
//        }
//        
//        init?(intValue: Int) {
//            self.stringValue = String(intValue)
//            self.intValue = intValue
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//
//        var tempPairs = [Int: [Int: String]]()
//        var tempSearchId: Int?
//
//        for key in container.allKeys {
//            if key.stringValue == "Search:", let searchId = try? container.decodeIfPresent(Int.self, forKey: key) {
//                tempSearchId = searchId
//            } else {
//                // `DynamicCodingKeys`를 사용해 키별로 디코딩
//                let nestedContainer = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: key)
//                var childPairs = [Int: String]()
//                for childKey in nestedContainer.allKeys {
//                    let value = try nestedContainer.decode(String.self, forKey: childKey)
//                    childPairs[childKey.intValue ?? 0] = value
//                }
//                tempPairs[key.intValue ?? 0] = childPairs
//            }
//        }
//
//        self.pairs = tempPairs
//        self.searchId = tempSearchId
//    }
//}
