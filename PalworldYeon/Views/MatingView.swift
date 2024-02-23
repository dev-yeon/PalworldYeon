//
//  MatingView.swift
//  PalworldYeon
//
//  Created by yeon on 1/31/24.
//

import SwiftUI


struct MatingView: View {
    @StateObject private var viewModel = PalViewModel()
    
    var body: some View {
        VStack {
            // JSON 데이터를 사용하여 UI 구성
            if !viewModel.pals.isEmpty {
                // 예시: 첫 번째 'Pal'의 이름과 이미지를 표시
                Text(viewModel.pals[0].name)
                Image("palicon_\(viewModel.pals[0].palDeckNo)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
            
//                // 이미지 로딩에 따라 수정 필요
//                // 여기에 추가 UI 구성
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
        .onAppear {
            viewModel.loadPalsData() // 뷰가 표시될 때 JSON 데이터 로드
    
        }
    }
}
