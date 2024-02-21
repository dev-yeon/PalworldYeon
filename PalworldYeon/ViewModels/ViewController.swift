//
//  ViewController.swift
//  PalworldYeon
//
//  Created by yeon on 2/16/24.
//
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // JSON 파일 디코딩을 시도합니다.
        decodePalFromJSON()
    }
    
    func decodePalFromJSON() {
        // Bundle에서 JSON 파일의 URL을 찾습니다.
        guard let jsonURL = Bundle.main.url(forResource: "palData", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        
        do {
            // JSON 파일에서 데이터를 로드합니다.
            let jsonData = try Data(contentsOf: jsonURL)
            
            // JSONDecoder를 사용하여 JSON 데이터를 Pal 구조체로 디코딩합니다.
            let decoder = JSONDecoder()
            let palData = try decoder.decode(Pal.self, from: jsonData)
            
            // 디코딩된 데이터를 출력하여 확인합니다.
            print(palData)
        } catch {
            // 오류가 발생하면 콘솔에 출력합니다.
            print("Error decoding JSON: \(error)")
        }
    }
}
