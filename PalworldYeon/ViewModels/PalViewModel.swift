//
//  PalViewModel.swift
//  PalworldYeon
//
//  Created by yeon on 2/16/24.

//  Pal 객체들을 로드하고 관리할 뷰 모델을 생성

import Foundation

class PalViewModel: ObservableObject {
    @Published var pals: [Pal] = [] 

    func loadPalsData() {
        guard let url = Bundle.main.url(forResource: "palData", withExtension: "json") else {
            print("Failed to locate palData.json in bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            print("로드된 데이터 크기: \(data.count) 바이트")
            // JSON 데이터를 문자열로 변환하여 출력 (큰 데이터의 경우 성능 저하 주의)
            // let jsonString = String(data: data, encoding: .utf8)
            // print("로드된 JSON 데이터: \(jsonString ?? "데이터 변환 실패")")
            self.pals = try JSONDecoder().decode([Pal].self, from: data)
            print("디코드된 Pal 객체 수: \(self.pals.count)")
            
        } catch {
            print("Failed to load palData.json from bundle: \(error) ...")
        }
    }
}
