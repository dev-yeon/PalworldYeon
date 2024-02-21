//
//  CircleImage.swift
//  PalworldYeon
//
//  Created by yeon on 1/29/24.
//

import SwiftUI


struct CircleImage: View {
    var body: some View {
        Image("cattiva")
            .clipShape(Circle())
            .overlay {
                      Circle().stroke(.gray, lineWidth: 4)
                  }
            .shadow(radius: 7)
    }
}


#Preview {
    CircleImage()
}
