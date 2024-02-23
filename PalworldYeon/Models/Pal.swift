import Foundation

// MARK: - Pal
struct Pal: Codable {
    var id: Int
    var image: String?
    var name: String
    var palDeckNo: String
    var element1: Element
    var element2: Element?
    var workAptitudes: WorkAptitude
    var otherInfo: OtherInfo
    var skill: Skill
    
    enum CodingKeys: String, CodingKey {
        case id, image, name, palDeckNo, element1, element2
        // 'workAptitudes' 내부 필드를 여기에 추가하지 않음  otherInfo, skill 또한
        case     kindling, watering, planting, electricity, crafting, gathering, deforesting, mining,
                 medicine_production, cooling, transporting, farming, work01, work02, work03
        //otherInfo
        case foodIntake, riding, equipmentNeeded
        // skill
        case skillName, description
    }
    // Decodable 요구 사항을 충족시키는 커스텀 init(from:) 메서드
    init(from decoder: Decoder) throws {
        // 디코딩 로직...
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        name = try container.decode(String.self, forKey: .name)
        palDeckNo = try container.decode(String.self, forKey: .palDeckNo)
        element1 = try container.decode(Element.self, forKey: .element1)
        // element2를 안전하게 디코딩
        if let element2String = try container.decodeIfPresent(String.self, forKey: .element2), !element2String.isEmpty {
            element2 = Element(rawValue: element2String)
        } else {
            element2 = nil
        }
        //        workAptitudes = try container.decode(WorkAptitude.self, forKey: .workAptitudes)
        // OtherInfo 관련 필드 디코딩
        let foodIntake = try container.decode(Int.self, forKey: .foodIntake)
        let riding = try container.decode(String.self, forKey: .riding)
        let equipmentNeeded = try container.decode(String.self, forKey: .equipmentNeeded)
        otherInfo = OtherInfo(foodIntake: foodIntake, riding: riding, equipmentNeeded: equipmentNeeded)
        
        // Skill 관련 필드 디코딩
        let skillName = try container.decode(String.self, forKey: .skillName)
        let description = try container.decode(String.self, forKey: .description)
        skill = Skill(skillName: skillName, description: description)
        
        // 'workAptitudes' 관련 필드를 개별적으로 디코딩
        
        // 각 'workAptitudes' 필드를 옵셔널 문자열로 디코딩하고, 안전하게 Int로 변환
        let kindling = try container.decodeIfPresent(String.self, forKey: .kindling).flatMap { Int($0) } ?? 0
        let watering = try container.decodeIfPresent(String.self, forKey: .watering).flatMap { Int($0) } ?? 0
        let planting = try container.decodeIfPresent(String.self, forKey: .planting).flatMap { Int($0) } ?? 0
        let electricity = try container.decodeIfPresent(String.self, forKey: .electricity).flatMap { Int($0) } ?? 0
        let crafting = try container.decodeIfPresent(String.self, forKey: .crafting).flatMap { Int($0) } ?? 0
        let gathering = try container.decodeIfPresent(String.self, forKey: .gathering).flatMap { Int($0) } ?? 0
        let deforesting = try container.decodeIfPresent(String.self, forKey: .deforesting).flatMap { Int($0) } ?? 0
        let mining = try container.decodeIfPresent(String.self, forKey: .mining).flatMap { Int($0) } ?? 0
        let medicine_production = try container.decodeIfPresent(String.self, forKey: .medicine_production).flatMap { Int($0) } ?? 0
        let cooling = try container.decodeIfPresent(String.self, forKey: .cooling).flatMap { Int($0) } ?? 0
        let transporting = try container.decodeIfPresent(String.self, forKey: .transporting).flatMap { Int($0) } ?? 0
        let farming = try container.decodeIfPresent(String.self, forKey: .farming).flatMap { Int($0) } ?? 0
        let work01 = try container.decodeIfPresent(String.self, forKey: .work01).flatMap { Int($0) } ?? 0
        let work02 = try container.decodeIfPresent(String.self, forKey: .work02).flatMap { Int($0) } ?? 0
        let work03 = try container.decodeIfPresent(String.self, forKey: .work03).flatMap { Int($0) } ?? 0
        //        let kindlingString = try container.decodeIfPresent(String.self, forKey: .kindling)
        //        let kindling = Int(kindlingString ?? "") ?? 0
        //
        //
        //        let wateringString = try container.decodeIfPresent(String.self, forKey: .watering)
        //        let watering = Int(wateringString ?? "") ?? 0
        //
        //        let plantingString = try container.decodeIfPresent(String.self, forKey: .planting)
        //        let planting = Int(plantingString ?? "") ?? 0
        //
        //        let electricityString = try container.decodeIfPresent(String.self, forKey: .electricity)
        //        let electricity = Int(electricityString ?? "") ?? 0
        //
        //        let craftingString = try container.decodeIfPresent(String.self, forKey: .crafting)
        //        let crafting = Int(craftingString ?? "") ?? 0
        //
        //        let gatheringString = try container.decodeIfPresent(String.self, forKey: .gathering)
        //        let gathering = Int(gatheringString ?? "") ?? 0
        //
        //        let deforestingString = try container.decodeIfPresent(String.self, forKey: .deforesting)
        //        let deforesting = Int(deforestingString ?? "") ?? 0
        //
        //        let miningString = try container.decodeIfPresent(String.self, forKey: .mining)
        //        let mining = Int(miningString ?? "") ?? 0
        //
        //        let medicine_productionString = try container.decodeIfPresent(String.self, forKey: .medicine_production)
        //        let medicine_production = Int(medicine_productionString ?? "") ?? 0
        //
        //        let coolingString = try container.decodeIfPresent(String.self, forKey: .cooling)
        //        let cooling = Int(coolingString ?? "") ?? 0
        //
        //        let transportingString = try container.decodeIfPresent(String.self, forKey: .transporting)
        //        let transporting = Int(transportingString ?? "") ?? 0
        //
        //        let farmingString = try container.decodeIfPresent(String.self, forKey: .farming)
        //        let farming = Int(farmingString ?? "") ?? 0
        //
        //        let work01String = try container.decodeIfPresent(String.self, forKey: .work01)
        //        let work01 = Int(work01String ?? "") ?? 0
        //
        //        let work02String = try container.decodeIfPresent(String.self, forKey: .work02)
        //        let work02 = Int(work02String ?? "") ?? 0
        //
        //        let work03String = try container.decodeIfPresent(String.self, forKey: .work03)
        //        let work03 = Int(work03String ?? "") ?? 0
        
        
        workAptitudes = WorkAptitude(kindling: kindling, watering: watering, planting: planting, electricity: electricity, crafting: crafting, gathering: gathering, deforesting: deforesting, mining: mining, medicine_production: medicine_production, cooling: cooling, transporting: transporting, farming: farming, work01: work01, work02: work02, work03: work03)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encode(name, forKey: .name)
        try container.encode(palDeckNo, forKey: .palDeckNo)
        try container.encode(element1, forKey: .element1)
        try container.encodeIfPresent(element2, forKey: .element2)
        // workAptitudes와 같은 복합 속성은 개별적으로 인코딩
        try container.encode(workAptitudes.kindling, forKey: .kindling)
        try container.encode(workAptitudes.watering, forKey: .watering)
        try container.encode(workAptitudes.planting, forKey: .planting)
        try container.encode(workAptitudes.electricity, forKey: .electricity)
        
        try container.encode(workAptitudes.crafting, forKey: .crafting)
        try container.encode(workAptitudes.gathering, forKey: .gathering)
        try container.encode(workAptitudes.deforesting, forKey: .deforesting)
        
        
        try container.encode(workAptitudes.mining, forKey: .mining)
        
        try container.encode(workAptitudes.medicine_production, forKey: .medicine_production)
        try container.encode(workAptitudes.cooling, forKey: .cooling)
        
        try container.encode(workAptitudes.transporting, forKey: .transporting)
        try container.encode(workAptitudes.farming, forKey: .farming)
        
        try container.encode(workAptitudes.work01, forKey: .work01)
        try container.encode(workAptitudes.work02, forKey: .work02)
        try container.encode(workAptitudes.work03, forKey: .work03)
        
        // OtherInfo 관련 필드 인코딩
        try container.encode(otherInfo.foodIntake, forKey: .foodIntake)
        try container.encode(otherInfo.riding, forKey: .riding)
        try container.encode(otherInfo.equipmentNeeded, forKey: .equipmentNeeded)
        // Skill 관련 필드 인코딩
        try container.encode(skill.skillName, forKey: .skillName)
        try container.encode(skill.description, forKey: .description)
    }
}

// MARK: - Element
enum Element: String, Codable {
    case normal, fire, dark, dragon, earth, electricity, ice, leaf, water, elements01, elements02, elements03
}

// MARK: - WorkAptitude
struct WorkAptitude: Codable {
    var kindling: Int?
    var watering: Int?
    var planting: Int?
    var electricity: Int?
    
    var crafting: Int?
    var gathering: Int?
    var deforesting: Int?
    
    var mining: Int?
    
    var medicine_production: Int?
    var cooling: Int?
    
    var transporting: Int?
    var farming: Int?
    
    var work01: Int?
    var work02: Int?
    var work03: Int?
}

// MARK: - OtherInfo
struct OtherInfo: Codable {
    var foodIntake: Int
    var riding: String
    var equipmentNeeded: String
}

// MARK: - Skill
struct Skill: Codable {
    var skillName: String
    var description: String
}
