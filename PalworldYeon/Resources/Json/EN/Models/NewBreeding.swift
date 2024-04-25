//
//  NewBreeding.swift
//  PalworldYeon
//
//  Created by yeon on 4/15/24.
//

import Foundation


// Define a struct for handling breeding relationships with more descriptive property names.
struct BreedingRelationships: Codable {
    var childPalKey: String
    var parentPalKeyPairs: [[String]]


}
// Implement custom coding keys to match the JSON structure with the model properties.
//    enum CodingKeys: String, CodingKey {
//        case childPalKey = "id"
//        case parentPalKeyPairs = "pairings"
//    }
