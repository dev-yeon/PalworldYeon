import Foundation

// MARK: - Pal 구조체
struct Pal: Identifiable,Codable  {
    var id: Int
    var image: String?
    var name: String
    var palDeckNo: String
    var element1: Element
    var element2: Element?
    var workAptitudes: WorkAptitude
    var otherInfo: OtherInfo
    var skill: Skill
   // var parents: [Int] = [] // 부모 Pal의 ID 목록 추가
    
    enum CodingKeys: String, CodingKey {
        case id, image, name, palDeckNo, element1, element2
        // 'workAptitudes' 내부 필드를 여기에 추가하지 않음
        case     kindling, watering, planting, electricity, crafting, gathering, deforesting, mining,
                 medicine_production, cooling, transporting, farming, work01, work02, work03
        //otherInfo
        case foodIntake, riding, equipmentNeeded
        // skill
        case skillName, description
        
        case parents
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        name = try container.decode(String.self, forKey: .name)
        palDeckNo = try container.decode(String.self, forKey: .palDeckNo)
        element1 = try container.decode(Element.self, forKey: .element1)
        
        if let element2String = try container.decodeIfPresent(String.self, forKey: .element2), !element2String.isEmpty {
            element2 = Element(rawValue: element2String)
        } else {
            element2 = nil
        }
        
        let kindling = Pal.decodeIntFromString(forKey: .kindling, from: container)
        let watering = Pal.decodeIntFromString(forKey: .watering, from: container)
        let planting = Pal.decodeIntFromString(forKey: .planting, from: container)
        let electricity = Pal.decodeIntFromString(forKey: .electricity, from: container)
        let crafting = Pal.decodeIntFromString(forKey: .crafting, from: container)
        let gathering = Pal.decodeIntFromString(forKey: .gathering, from: container)
        let deforesting = Pal.decodeIntFromString(forKey: .deforesting, from: container)
        let mining = Pal.decodeIntFromString(forKey: .mining, from: container)
        let medicine_production = Pal.decodeIntFromString(forKey: .medicine_production, from: container)
        let cooling = Pal.decodeIntFromString(forKey: .cooling, from: container)
        let transporting = Pal.decodeIntFromString(forKey: .transporting, from: container)
        let farming = Pal.decodeIntFromString(forKey: .farming, from: container)
        _ = Pal.decodeIntFromString(forKey: .work01, from: container)
        _ = Pal.decodeIntFromString(forKey: .work02, from: container)
        _ = Pal.decodeIntFromString(forKey: .work03, from: container)

        let foodIntake = try container.decode(Int.self, forKey: .foodIntake)
        let riding = try container.decode(String.self, forKey: .riding)
        let equipmentNeeded = try container.decode(String.self, forKey: .equipmentNeeded)
        otherInfo = OtherInfo(foodIntake: foodIntake, riding: riding, equipmentNeeded: equipmentNeeded)
        
      
        let skillName = try container.decode(String.self, forKey: .skillName)
        let description = try container.decode(String.self, forKey: .description)
        skill = Skill(skillName: skillName, description: description)
        
        
        workAptitudes = WorkAptitude(kindling: kindling, watering: watering, planting: planting, electricity: electricity, crafting: crafting, gathering: gathering, deforesting: deforesting, mining: mining, medicine_production: medicine_production, cooling: cooling, transporting: transporting, farming: farming, work01: 0, work02: 0, work03: 0)
    }
    // MARK: - String ->Int 해주는 함수
    static func decodeIntFromString(forKey key: CodingKeys, from container: KeyedDecodingContainer<CodingKeys>) -> Int {
        if let stringValue = try? container.decodeIfPresent(String.self, forKey: key),
           let intValue = Int(stringValue) {
            return intValue
        } else if let intValue = try? container.decodeIfPresent(Int.self, forKey: key) {
            return intValue
        } else {
            return 0
        }
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

extension Pal {
    init(id: Int, image: String?, name: String, palDeckNo: String, element1: Element, element2: Element?, workAptitudes: WorkAptitude, otherInfo: OtherInfo, skill: Skill) {
        self.id = id
        self.image = image
        self.name = name
        self.palDeckNo = palDeckNo
        self.element1 = element1
        self.element2 = element2
        self.workAptitudes = workAptitudes
        self.otherInfo = otherInfo
        self.skill = skill
    }
}
extension Pal: Hashable {
    static func == (lhs: Pal, rhs: Pal) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
