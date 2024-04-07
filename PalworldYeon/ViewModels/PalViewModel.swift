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
        // ID로 Pal을 찾기 전에 로그를 찍습니다.
        print("Finding Pal with ID: \(id)")

        if let foundPal = pals.first(where: { $0.id == id }) {
            // Pal을 찾았을 때 로그를 찍습니다.
            print("Found Pal: \(foundPal.name)")
            return foundPal.name
        } else {
            // Pal을 찾지 못했을 때 로그를 찍습니다.
            print("No Pal found with ID: \(id)")
            return nil
        }
    }

    func filterBreedingPairs(with text: String) {
        print("Filtering with text: \(text) <-주어진 ID로 Pal 이름")
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

