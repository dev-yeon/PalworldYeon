//
//  ViewController.swift
//  PalworldYeon
//
//  Created by yeon on 2/16/24.
//
import Foundation


class PalViewModel: ObservableObject {
    @Published var pals: [Pal] = []
    @Published var searchNumber: Int?
    private var palManager = PalManager()


    
//MARK: - 주어진 ID로 Pal 이름을 찾는 함수
    func findingPalName(forId id: Int) -> String? {
        if let foundPal = pals.first(where: { $0.id == id }) {
            return foundPal.name
        } else {
            return nil
        }
    }

    func filterBreedingPairs(with text: String) {
    }

}
//MARK: - 기존 변환 함수들은 유지
extension PalViewModel {
    func convertStringIdToInt(_ id: String) -> Int? {
        return Int(id)
    }
    
    func convertIntIdToString(_ id: Int) -> String {
        return String(id)
    }
}

