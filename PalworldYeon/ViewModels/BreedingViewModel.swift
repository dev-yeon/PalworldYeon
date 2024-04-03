////
////  BreedingViewModel.swift
////  PalworldYeon
////
////  Created by yeon on 2/29/24.
//
//
//import Foundation
//import Combine
//
//class BreedingViewModel: ObservableObject {
//    @Published var parentPals: [Pal] = [] // 부모 Pal 객체의 배열
//    @Published var allBreedingData: [BreedingData] = []
//    @Published var selectedChildName: String?
//    @Published var allAvailablePals: [Pal] = []
//    private var palManager = PalManager() // PalManager 인스턴스 생성
//    
//    //MARK: - Pal의 가능한 교배식을 Pal 자식의 childName으로 찾아내는 함수
//    func findParentPairs(forChildName childName: String) {
//        var foundParentPairs: [Pal] = []
//        
//        for breedingData in allBreedingData {
//            for pair in breedingData.breedings where pair.childName.lowercased() == childName.lowercased() {
//                
//                if let motherPal = palManager.findPalByName(breedingData.motherName),
//                   let fatherPal = findPalById(pair.fatherid) {
//                    foundParentPairs.append(contentsOf: [motherPal, fatherPal])
//                    print("Found \(pair.childName)'s parent pair: \(motherPal.name), \(fatherPal.id)")
//                }
//            }
//        }
//        DispatchQueue.main.async {
//            self.parentPals = foundParentPairs
//            print("Updated parentPals with \(foundParentPairs.count) parents.")
//        }
//    }
//    //MARK: -  Pal을 id로 찾아내는 메소드
//    func findPalById(_ id: Int) -> Pal? {
//        print("Available Pals count: \(allAvailablePals.count)")
//        return allAvailablePals.first { $0.id == id }
//    }
//    //MARK: - 선택된 자식 Pal의 이름을 설정하는 메소드
//    func setSelectedChildName(_ name: String?) {
//        self.selectedChildName = name
//        // 선택된 이름에 기반한 추가 작업이 필요하다면 여기서 수행
//    }
//}
