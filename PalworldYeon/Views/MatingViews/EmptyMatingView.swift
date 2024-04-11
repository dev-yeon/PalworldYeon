//
//  EmptyMatingView.swift
//  PalworldYeon
//
//  Created by yeon on 3/29/24.
//

import SwiftUI

struct EmptyMatingView: View {
    var body: some View {
        
        VStack {
            Image(systemName: "magnifyingglass") 
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Text("해당 팰을 찾을 수 없습니다.")
                .font(.title3)
        }
        .padding()
        .foregroundColor(.secondary)
    }
}


#Preview {
    EmptyMatingView()
}
