//
//  EnPal.swift
//  PalworldYeon
//
//  Created by yeon on 4/12/24.
//


import Foundation

// Define the types used in the JSON structure
struct Type: Codable {
    var name: String
    var image: String
}

struct Work: Codable {
    var type: String
    var image: String
    var level: Int
}

struct Skill: Codable {
    var level: Int
    var name: String
    var type: String
    var cooldown: Int
    var power: Int
    var description: String
}

struct Stats: Codable {
    var hp: Int
    var attack: Attack
    var defense: Int
    var speed: Speed
    var stamina: Int
    var support: Int
    var food: Int

    struct Attack: Codable {
        var melee: Int
        var ranged: Int
    }

    struct Speed: Codable {
        var ride: Int
        var run: Int
        var walk: Int
    }
}

struct Map: Codable {
    var day: String
    var night: String
}

struct Breeding: Codable {
    var rank: Int
    var order: Int
    var childEligible: Bool
    var maleProbability: Double

    enum CodingKeys: String, CodingKey {
        case rank, order, childEligible = "child_eligble", maleProbability = "male_probability"
    }
}

struct Aura: Codable {
    var name: String
    var description: String
    var tech: String?
}

struct Creature: Codable {
    var id: String
    var key: String
    var image: String
    var name: String
    var wiki: String
    var types: [Type]
    var imageWiki: String
    var suitability: [Work]
    var drops: [String]
    var aura: Aura
    var description: String
    var skills: [Skill]
    var stats: Stats
    var asset: String
    var genus: String
    var rarity: Int
    var price: Int
    var size: String
    var maps: Map
    var breeding: Breeding
}
