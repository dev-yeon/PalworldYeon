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
            // Pal Detail Tab
            PalDexListView()
                .tabItem {
                    Image(systemName: "list.bullet.circle")
                    Text("PalDex")
                }
                .tag(1)
            // Map Tab
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
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
        return "PalDex"
    case 2:
        return "Map"
    default:
        return "Home"
    }
}



