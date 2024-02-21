//
//  Pal.swift
//  PalworldYeon
//
//  Created by yeon on 2/17/24.
//

import Foundation



//MARK:  - pal 의 기본 속성들
struct Pal: Codable {
    var id: Int
    var image: String?
    var name: String
    var element1: Element
    var element2: Element?
    var workAptitudes: WorkAptitude
    var otherInfo: OtherInfo
    var skill: Skill
    
    enum CodingKeys: String, CodingKey {
        case id, image, name, element1, element2, workAptitudes, otherInfo, skill
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        image = try container.decodeIfPresent(String.self, forKey: .image) // 이미지가 옵셔널일 경우를 위해 decodeIfPresent 사용
        name = try container.decode(String.self, forKey: .name)
        element1 = try container.decode(Element.self, forKey: .element1)
        
        // element2를 안전하게 디코딩
        if let element2String = try container.decodeIfPresent(String.self, forKey: .element2), !element2String.isEmpty {
            element2 = Element(rawValue: element2String)
        } else {
            element2 = nil
        }
        
        // WorkAptitude 인스턴스를 생성하여 디코딩
        workAptitudes = try container.decode(WorkAptitude.self, forKey: .workAptitudes)
        otherInfo = try container.decode(OtherInfo.self, forKey: .otherInfo)
        skill = try container.decode(Skill.self, forKey: .skill)
    }
}
//MARK: - Element

enum Element: String, Codable {
    case normal, fire, dark, dragon, earth, electricity, ice, leaf, water, elements01, elements02, elements03

}

//MARK: - pal 의 작업 적합도
struct WorkAptitude: Codable {
    var farming, mining, crafting, cooling, deforesting, electricity, gathering, handiwork, kindling, medicine_production, planting, transporting, watering, work01, work02, work03 : Int

}

// MARK: - OtherInfo
struct OtherInfo: Codable {
    var foodIntake: Int
    var riding, equipmentNeeded: String
}

// MARK: - Skill
struct Skill: Codable {
    var skillName: String
    var description: String
   
}



