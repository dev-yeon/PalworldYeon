//
//  ViewController.swift
//  PalworldYeon
//
//  Created by yeon on 2/16/24.
//
import Foundation

class PalViewModel: ObservableObject {
    @Published var pals: [Pal] = []
    var parentMappings: [Int: [Int]] = [:]

    init() {
        loadPalsData()
        loadPalBreedingData()
    }

    func loadPalsData() {
        guard let url = Bundle.main.url(forResource: "palData", withExtension: "json") else {
            print("Failed to locate palData.json in bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            self.pals = try JSONDecoder().decode([Pal].self, from: data)
        } catch {
            print("Failed to load palData.json from bundle: \(error)")
        }
    }
    
    func loadPalBreedingData() {
        guard let url = Bundle.main.url(forResource: "PalBreedingData", withExtension: "json") else {
            print("Failed to locate PalBreedingData.json in bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            self.pals = try JSONDecoder().decode([Pal].self, from: data)
        } catch {
            print("Failed to load PalBreedingData.json from bundle: \(error)")
        }
    }
    
}
//extension PalViewModel {
//    func determineParents(forChildId childId: Int?) -> [Pal] {
//        guard let childId = childId else {
//            return []
//        }
//        
//        // Here you would implement the logic to determine parents based on the childId
//        // For example, you can filter the list of Pal objects to find those with matching parent IDs
//        
//        var parents: [Pal] = []
//        for pal in pals {
//            if pal.parents.contains(childId) {
//                parents.append(pal)
//            }
//        }
//        
//        return parents
//    }
//}
