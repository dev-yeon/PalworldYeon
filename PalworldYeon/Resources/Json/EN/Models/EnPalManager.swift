//
//  EnPalManager.swift
//  PalworldYeon
//
//  Created by yeon on 4/15/24.
//

import Foundation
import Combine


class EnPalManager: ObservableObject  {
    @Published var enPals: [EnPal] = []
    @Published var allNewBreedingData: [BreedingRelationships] = []


    //MARK: - 영어로 된 enPals를 불러오는 함수
    func loadEnPalsData(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = Bundle.main.url(forResource: "EnPals", withExtension: "json") else {
                print("Failed to locate EnPals.json in bundle.")
                DispatchQueue.main.async {
                    completion()
                }
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let decodedenPalsArray = try JSONDecoder().decode([EnPalCreature].self, from: data)
                DispatchQueue.main.async {
                    self.enPals = decodedenPalsArray
                    print("Loaded \(self.enPals.count) data records.")
                    completion()
                }
            } catch {
                print("Failed to load EnPals.json from bundle: \(error)")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }


    //MARK: - breeding를 불러오는 함수
    func loadBreedingData(completion: @escaping () -> Void) {
        // Locate the JSON file in the app bundle.
        guard let url = Bundle.main.url(forResource: "breeding", withExtension: "json") else {
            print("Failed to locate breeding.json in bundle.")
            completion()  // Call completion even if the file is not found to handle the error appropriately.
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                // Load the JSON data.
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                // Decode the JSON data into an array of BreedingData.
                let decodedNewBreedingDataArray = try decoder.decode([BreedingRelationships].self, from: data)

                DispatchQueue.main.async {
                    // Update the main thread with the decoded data.
                    self.allNewBreedingData = decodedNewBreedingDataArray
                    print("Loaded \(self.allNewBreedingData.count) breeding data records.")
                    completion()  // Call the completion handler to signal that loading and parsing are complete.
                }
            } catch {
                print("Failed to load breeding.json from bundle: \(error)")
                DispatchQueue.main.async {
                    completion()  // Ensure the completion handler is called even if there is an error.
                }
            }
        }
    }

    //MARK: - items detail 불러오는 함수




}
