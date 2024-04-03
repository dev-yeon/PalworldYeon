//
//  PalworldYeonApp.swift
//  PalworldYeon
//
//  Created by yeon on 1/29/24.
//

import SwiftUI

@main
struct PalworldYeonApp: App {
    var palManager = PalManager()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(palManager)
        }
        //도로롱
    }
}
 
