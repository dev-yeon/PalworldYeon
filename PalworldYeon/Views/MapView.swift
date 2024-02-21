//
//  MapView.swift
//  PalworldYeon
//
//  Created by yeon on 1/29/24.
//
import SwiftUI
import MapKit


struct MapView: View {
    var body: some View {
        Text("배경")
    }


    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}


#Preview {
    MapView()
}
