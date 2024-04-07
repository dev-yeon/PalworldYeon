//
//  PalManager.swift
//  PalworldYeon
//
//  Created by yeon on 3/28/24.
//

import Foundation



class PalManager: ObservableObject  {
    //MARK: - Pal 객체들의 데이터를 이름을 키로 하여 저장하는 딕셔너리

    @Published var palDataDictionary: [String: Pal] = [:]
    @Published var pals: [Pal] = []
    @Published var allBreedingData: [BreedingData] = []

    @Published var parentPals: [Pal] = [] // 부모 Pal 객체의 배열
    @Published var parentPairs: [ParentPalPair] = []

    @Published var selectedChildName: String?

//    @Published var allAvailablePals: [Pal] = []
    // 이미 생성된 Pal 객체를 관리하는 캐시
    var palCache: [String: Pal] = [:]

    //MARK: - palData JSON 파일 로드 및 파싱

        func loadPalsData() {
            guard let url = Bundle.main.url(forResource: "palData", withExtension: "json") else {
                print("Failed to locate palData.json in bundle.")
                return
            }

            do {
                let data = try Data(contentsOf: url)
                self.pals = try JSONDecoder().decode([Pal].self, from: data)
                print("Loaded \(self.pals.count) data records.")
            } catch {
                print("Failed to load palData.json from bundle: \(error)")
            }
        }
    //MARK: - new_palBreedingData JSON 파일 로드 및 파싱
    func loadBreedingData(completion: @escaping () -> Void) {

        guard let url = Bundle.main.url(forResource: "new_palBreedingData", withExtension: "json") else {
            print("Failed to locate new_palBreedingData.json in bundle.")
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedBreedingDataArray = try decoder.decode([BreedingData].self, from: data)
                DispatchQueue.main.async {
                    self.allBreedingData = decodedBreedingDataArray
                    print("Loaded \(self.allBreedingData.count) breeding data records.")
                    print("Breeding data loaded successfully.")


                    completion()
                }
            } catch {
                print("Failed to load new_palBreedingData.json from bundle: \(error)")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }

    //MARK: -  이름으로 Pal을 찾아내는 함수
    func findPalByName(_ name: String) -> Pal? {

        let lowercasedName = name.lowercased()
        if let foundPal = pals.first(where: { $0.name.lowercased() == lowercasedName }) {
            return foundPal
        } else {
            return nil
        }
    }
    //MARK: - Pal의 가능한 교배식을 Pal 자식의 childName으로 찾아내는 함수
    func findParentPairs(forChildName childName: String) {

        var foundPairs = Set<ParentPalPair>() // 중복을 방지하기 위해 Set 사용
        print("Searching parent pairs for child: \(childName)")

        for breedingData in allBreedingData {

            for pair in breedingData.breedings where pair.childName.lowercased() == childName.lowercased() {
                if let motherPal = findPalByName(breedingData.motherName),
                   let fatherPal = findPalById(pair.fatherid) {
                    // Add to the set, automatically avoiding duplicates
                    let parentPair = ParentPalPair(mother: motherPal, father: fatherPal)
                    foundPairs.insert(parentPair) // Set에 추가
                    //foundParentPairs.append(contentsOf: [motherPal, fatherPal])
                    print("\(pair.childName)'s parent pair || mother:  \(motherPal.name), father : \(findFatherNameById(fatherPal.id))")
                }
            }
        }
        DispatchQueue.main.async {
            self.parentPairs = Array(foundPairs) // Convert back to an array if needed

            print("Updated parentPals with \(foundPairs.count) parents.")
        }
    }
    //MARK: -  Pal을 id로 찾아내는 메소드
    func findPalById(_ id: Int) -> Pal? {
        return pals.first { $0.id == id }
    }
    //MARK: - 선택된 자식 Pal의 이름을 설정하는 메소드
    func setSelectedChildName(_ name: String?) {
        self.selectedChildName = name
        // 선택된 이름에 기반한 추가 작업이 필요하다면 여기서 수행
    }

   func findFatherNameById(_ id: Int) -> String {
        if let father = pals.first(where: { $0.id == id }) {
            return father.name
        } else {
            return "Unknown"
        }
    }
}