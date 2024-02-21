//
//  PalDataModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/16/24.
//

//import Foundation
//
//// Codable 프로토콜을 준수하는 구조체를 정의합니다.
//struct Pal: Codable {
//    let id: String
//    let palImage: String
//    let palName: String
//    let palElements: String
//    let palRarity: Int
//    let palSize: String
//    let stats: Stats
//    let palPassiveSkill: PalPassiveSkill
//    let palActiveSkills: [PalActiveSkill]
//    let palPartnerSkill: PalPartnerSkill
//    let palWorkAptitude: [String: Int]
//    let palOtherInfo: PalOtherInfo
//}
//
//struct Stats: Codable {
//    let palHealth: Int
//    let palAttackMelee: Int
//    let palAttackShot: Int
//    let palDefense: Int
//    let palStamina: Int
//    let palWorkSpeed: Int
//    let palSlowWalkSpeed: Int
//    let palWalkSpeed: Int
//    let palRunSpeed: Int
//}
//
//struct PalPassiveSkill: Codable {
//    let palPassiveSkillName: String
//    let palPassiveSkillType: String
//    let palPassiveSkillEffect: String
//}
//
//struct PalActiveSkill: Codable {
//    let palActiveSkillName: String
//    let palActiveSkillDescription: String
//    let palAcquisitionLevel: Int
//    let palActiveSkillCoolTime: Int
//    let palActiveSkillType: String
//    let palActiveSkillElements: String
//}
//
//struct PalPartnerSkill: Codable {
//    let palPartnerSkillName: String
//    let palPartnerSkillDescription: String
//}
//
//struct PalOtherInfo: Codable {
//    let palFoodIntake: Int
//    let palSalePrice: Int
//    let palCarryingSpeed: Int
//    let palNormalDrop: String
//}
//
//// JSON을 디코드하는 예시 함수
//func decodePalFromJSON() {
//    let jsonURL = Bundle.main.url(forResource: "pal_data", withExtension: "json")!
//    let jsonData = try! Data(contentsOf: jsonURL)
//    let decoder = JSONDecoder()
//    let palData = try! decoder.decode(Pal.self, from: jsonData)
//    
//    print(palData)
//}
//
//// 디코드 함수 호출
////decodePalFromJSON()
