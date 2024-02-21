//
//  PalViewModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/16/24.

//  Pal 객체들을 로드하고 관리할 뷰 모델을 생성

import Foundation

class PalViewModel: ObservableObject {
    @Published var pals: [Pal] = [] // 'Pal' 객체들의 배열

    func loadPalsData() {
        guard let url = Bundle.main.url(forResource: "palData", withExtension: "json") else {
            print("Failed to locate palData.json in bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            self.pals = try JSONDecoder().decode([Pal].self, from: data)
        } catch {
            print("Failed to load palData.json from bundle: \(error) ...")
        }
    }
}
