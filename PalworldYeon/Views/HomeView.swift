//
//  HomeView.swift
//  PalworldYeon
//
//  Created by yeon on 1/31/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
           
            // Mating Tab
            
            MatingView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Mating")
                }
                .tag(0)
            
            // Map Tab
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(1)
            
            // Setting Tab
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("setting")
                }
                .tag(2)
        }
        .navigationTitle(titleForSelectedTab(selectedTab))
    }
    
}

private func titleForSelectedTab(_ tab: Int) -> String {
    switch tab {
    case 0:
        return "Mating"
    case 1:
        return "Map"
    case 2:
        return "Setting"
    default:
        return "Home"
    }
}



#Preview {
    HomeView()
}
