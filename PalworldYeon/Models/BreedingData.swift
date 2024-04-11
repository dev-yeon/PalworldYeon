//
//  BreedingData.swift
//  PalworldYeon
//
//  Created by yeon on 3/1/24.
//
import Foundation
import Combine

struct BreedingData: Codable, Hashable {
    let motherName: String
    let breedings: [BreedingPair]
    
    struct BreedingPair: Codable, Hashable {
        let fatherid: Int
        let childName: String
    }
}
// 부모 펠 쌍을 나타내는 새로운 구조체
struct ParentPalPair: Hashable {
    let mother: Pal
    let father: Pal

    func hash(into hasher: inout Hasher) {
        hasher.combine(min(mother.id, father.id))
        hasher.combine(max(mother.id, father.id))
    }

    static func ==(lhs: ParentPalPair, rhs: ParentPalPair) -> Bool {
        return (lhs.mother.id == rhs.mother.id && lhs.father.id == rhs.father.id) ||
               (lhs.mother.id == rhs.father.id && lhs.father.id == rhs.mother.id)
    }
}
