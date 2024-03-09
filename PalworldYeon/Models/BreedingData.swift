//
//  BreedingData.swift
//  PalworldYeon
//
//  Created by yeon on 3/1/24.
//
import Foundation
import Combine

struct BreedingData: Codable {
    let motherName: String
    let breedings: [BreedingPair]
    
    struct BreedingPair: Codable {
        let fatherid: Int
        let childName: String
    }
}

