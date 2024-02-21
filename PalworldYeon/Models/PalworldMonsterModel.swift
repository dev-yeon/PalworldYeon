////
////  PalworldMonsterModel.swift
////  PalworldYeon
////
////  Created by yeon on 1/31/24.
////
//
//import Foundation
//
//struct Palmonster {
//    var id: String
//    var palName: String
//    var palImage: String
//    var palDescription: String
//    var stats: PalStats
//    var habitat: String
//    var passiveSkills: [PalSkill]
//    var workSkills: [PalWorkSkill]
//    var palElements: [Elements] // Palmonster can have one or two attributes
//}
//
//struct PalStats {
//    var palhealth: Int
//    var palattack: Int
//    var paldefense: Int
//    var palspeed: Int
//}
//
//struct PalSkill {
//    var id: String
//    var skillName: String
//    var skilltype: PalSkillType
//    var skilldescription: String
//    var skillElements : [Elements]
//    var skilllevelDetails: [PalSkillLevelDetail]
//}
//
//struct PalSkillLevelDetail {
//    var skillLevel: Int
//    var skillpower: Int
//    var skillcooldown: Int
//    var skillrange: Int
//}
//
//enum PalSkillType {
//    case active
//    case passive
//}
//
//struct PalWorkSkill {
//    var id: String
//    var workSkillName: String // Specific name for the work skill, like "불 피우기", "관개" etc.
//    var workFitLevel: Int
//}
//
//enum Elements {
//    case fire
//    case water
//    case earth
//    case plant
//    case electic
//    case ice
//    case dragon
//    case dark
//    case normal
//    
//}
//
//enum WorkSkillName {
//    
//}
