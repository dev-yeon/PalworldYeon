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
    @Published var allBreedingData: [BreedingData] = []
    
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
        print("findPalByName Available Pals count: \(allAvailablePals.count) ")

        // 배열에 있는 모든 이름 로깅
        allAvailablePals.forEach { pal in
            print("Available Pal: '\(pal.name)' (ID: \(pal.id))")
        }

        let lowercasedName = name.lowercased()
        if let foundPal = allAvailablePals.first(where: { $0.name.lowercased() == lowercasedName }) {
            print("Found Pal: '\(name)' for search name: '\(name)'")
            return foundPal
        } else {
            print("No Pal found for name: '\(name)'")
            return nil
        }
    }

    // Implementation of findPalById
    func findPalById(_ id: Int) -> Pal? {
        print("Available Pals count: \(allAvailablePals.count)")

        return allAvailablePals.first { $0.id == id }
    }
    
    // JSON 파일 로드 및 파싱 함수 수정
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
}
