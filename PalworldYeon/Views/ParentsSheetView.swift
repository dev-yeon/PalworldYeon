//
//  ParentsSheetView.swift
//  PalworldYeon
//
//  Created by yeon on 3/11/24.
//

import SwiftUI

struct ParentsSheetView: View {

    var parents: [Pal]
    var searchViewModel: SearchFieldViewModel

    var body: some View {
        NavigationView {
            HStack{
                Text("\(searchViewModel.results) Parents")
            }
            List(parents, id: \.id) { parent in
                HStack {
                    if let imageName = parent.image, !imageName.isEmpty {
                        // 이미지 이름을 사용하여 이미지 로드
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } else {
                        // 기본 이미지 표시
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    Text(parent.name)
                }
                .onAppear {
                                    print("Displaying parent: \(parent.name)")
                                }
            }
            .navigationBarTitle("\(searchViewModel.results) Parents", displayMode: .inline)
            
        }
    }
}


