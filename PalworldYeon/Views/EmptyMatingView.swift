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
            Image(systemName: "magnifyingglass") // Example icon
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Text("찾고 싶은 자식 펠의 이름 입력 ex)도로롱 '도'")
                .font(.caption)
        }
        .padding()
        .foregroundColor(.secondary)
    }
}


#Preview {
    EmptyMatingView()
}
