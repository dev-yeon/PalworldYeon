//
//  EnPal.swift
//  PalworldYeon
//
//  Created by yeon on 4/15/24.
//

import Foundation

enum TypeEnum: String, Codable {
    case neutral, grass, fire, water, electric, ice, ground, dark, dragon
}

enum ImageName: String, Codable {
    case kindling = "kindling.png",
         watering = "watering.png",
         planting = "planting.png",
         generatingElectricity = "generating_electricity.png",
         handiwork = "handiwork.png",
         gathering = "gathering.png",
         lumbering = "lumbering.png",
         mining = "mining.png",
         cooling = "cooling.png",
         transporting = "transporting.png",
         farming = "farming.png"
}

struct EnPal: Codable {
    struct CreatureType: Codable {
        let name: TypeEnum
        let image: ImageName
    }

    struct Suitability: Codable {
        let type: String
        let image: ImageName
        let level: Int
    }

    struct Aura: Codable {
        let name: String
        let description: String
        let tech: String?
    }

    struct Skill: Codable {
        let level: Int
        let name: String
        let type: TypeEnum
        let cooldown: Int
        let power: Int
        let description: String
    }

    struct Stats: Codable {
        struct Attack: Codable {
            let melee: Int
            let ranged: Int
        }

        struct Speed: Codable {
            let ride: Int
            let run: Int
            let walk: Int
        }

        let hp: Int
        let attack: Attack
        let defense: Int
        let speed: Speed
        let stamina: Int
        let support: Int
        let food: Int
    }

    struct Maps: Codable {
        let day: String
        let night: String
    }

    struct Breeding: Codable {
        let rank: Int
        let order: Int
        let childEligible: Bool
        let maleProbability: Double

        enum CodingKeys: String, CodingKey {
            case rank, order, childEligible = "child_eligble", maleProbability
        }
    }

    let id: Int
    let key: String
    let name: String
    let types: [CreatureType]
    let suitability: [Suitability]
    let drops: [String]
    let aura: Aura
    let description: String
    let skills: [Skill]
    let stats: Stats
    let asset, genus: String
    let rarity: Int
    let price: Int
    let size: String
    let maps: Maps
    let breeding: Breeding
}
