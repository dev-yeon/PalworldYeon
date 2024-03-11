//
//  BreedingViewModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/29/24.
//도로로

import Foundation
import Combine

class BreedingViewModel: ObservableObject {
    @Published var parentPals: [Pal] = [] // 부모 Pal 객체의 배열
    var allBreedingData: [BreedingData] = []
    
    var allAvailablePals: [Pal] = []
    
    func findParentPairs(forChildName childName: String) {
        var foundParentPals: [Pal] = []
        
        for breedingData in allBreedingData {
            for pair in breedingData.breedings where pair.childName.lowercased() == childName.lowercased() {
                
                if let mother = findPalByName(breedingData.motherName), let father = findPalById(pair.fatherid) {
                    foundParentPals.append(contentsOf: [mother, father])
                    print("Found \(pair.childName)'s parent pair: \(mother.name), \(father.name)")
                }
            }
        }
        
        DispatchQueue.main.async {
            self.parentPals = foundParentPals
            print("Updated parentPals with \(foundParentPals.count) parents.")
        }
    }
    // Implementation of findPalByName
    func findPalByName(_ name: String) -> Pal? {
        return allAvailablePals.first { $0.name.lowercased() == name.lowercased() }
    }

    // Implementation of findPalById
    func findPalById(_ id: Int) -> Pal? {
        return allAvailablePals.first { $0.id == id }
    }
    
    // JSON 파일 로드 및 파싱 함수 수정
    func loadBreedingData() {
        guard let url = Bundle.main.url(forResource: "new_palBreedingData", withExtension: "json") else {
            print("Failed to locate new_palBreedingData.json in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // JSON 파일로부터 BreedingData 배열을 디코딩합니다.
            let decodedBreedingDataArray = try decoder.decode([BreedingData].self, from: data)
            // 디코드된 데이터를 allBreedingData에 할당합니다.
            DispatchQueue.main.async {
                self.allBreedingData = decodedBreedingDataArray
                print("Loaded \(self.allBreedingData.count) breeding data records.")
            }
        } catch {
            print("Failed to load new_palBreedingData.json from bundle: \(error)")
        }
    }
}
