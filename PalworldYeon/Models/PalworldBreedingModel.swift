//
//  PalworldBreedingModel.swift
//  PalworldYeon
//
//  Created by yeon on 1/31/24.
//

import Foundation


struct BreedingModel {
    var parent1: PalmonReference
    var parent2: PalmonReference
    var offspring: [BreedingOutcome]
}

struct PalmonReference {
    var id: String
    var name: String
}

struct BreedingOutcome {
    var offspring: PalmonReference
    var probability: Double // 0.0 ~ 1.0 사이의 값으로 교배 확률을 나타냄
}
