//
//  PalBreedingData.swift
//  PalworldYeon
//
//  Created by yeon on 3/1/24.
//
import Foundation

struct PalBreedingData: Decodable {
    var pairs: [String: [String: String]] // 교배 쌍을 저장하는 딕셔너리
    var searchId: Int? // "Search:" 키에 해당하는 값

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempPairs = [String: [String: String]]()
        var tempSearchId: Int?

        for key in container.allKeys {
            if key.stringValue == "Search:", let searchId = try? container.decodeIfPresent(Int.self, forKey: key) {
                tempSearchId = searchId
            } else {
                // `DynamicCodingKeys`를 사용해 키별로 디코딩
                let nestedContainer = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: key)
                var childPairs = [String: String]()
                for childKey in nestedContainer.allKeys {
                    let value = try nestedContainer.decode(String.self, forKey: childKey)
                    childPairs[childKey.stringValue] = value
                }
                tempPairs[key.stringValue] = childPairs
            }
        }

        self.pairs = tempPairs
        self.searchId = tempSearchId
    }
}

//// PalBreedingData 구조체 정의
//struct PalBreedingData:  Decodable  {
//    var pairs: [String: [String: String]]
//    var searchId: Int?
//
//    private enum CodingKeys: String,CodingKey {
//        case search = "Search:"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        // 'Search:' 키에 대한 처리
//        self.searchId = try container.decodeIfPresent(Int.self, forKey: .search)
//
//        // 동적 키에 대한 처리를 위한 추가 컨테이너
//        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
//        var tempPairs = [String: [String: String]]()
//        
//        // 모든 키를 순회하며 디코딩
//        for key in dynamicContainer.allKeys {
//            // 'Search:' 키를 제외하고 처리
//            if key.stringValue != "Search:" {
//                // 여기에서 올바른 타입으로 디코딩하고 tempPairs에 할당
//                let value = try dynamicContainer.decode([String: String].self, forKey: key)
//                tempPairs[key.stringValue] = value
//            }
//        }
//        
//        self.pairs = tempPairs
//    }
//
//}
//
//struct DynamicCodingKeys: CodingKey {
//    var stringValue: String
//    var intValue: Int?
//    
//    init?(stringValue: String) {
//               self.stringValue = stringValue
//               self.intValue = nil
//           }
//           
//           init?(intValue: Int) {
//               self.stringValue = String(intValue)
//               self.intValue = intValue
//           }
//}


//struct PalBreedingData: Decodable {
//    var pairs: [String: [String: String]]
//    var searchId: Int?
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
//        var tempPairs = [String: [String: String]]()
//        var tempSearchId: Int?
//
//        for key in container.allKeys {
//            if key.stringValue == "Search:", let searchId = try? container.decodeIfPresent(Int.self, forKey: key) {
//                tempSearchId = searchId
//            } else {
//                let value = try container.decode([String: String].self, forKey: key)
//                tempPairs[key.stringValue] = value
//            }
//        }
//
//        self.pairs = tempPairs
//        self.searchId = tempSearchId
//    }
//}
