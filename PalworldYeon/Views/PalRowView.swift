//
//  PalRowView.swift
//  PalworldYeon
//
//  Created by yeon on 4/3/24.
//

import SwiftUI

struct PalRowView: View {
    var pal: Pal

    var body: some View {
        HStack {
            Text("No. \(pal.palDeckNo)")
                .padding(3)
            Image("palicon_\(pal.palDeckNo)")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            Text(pal.name)
                .lineSpacing(10.0)
        }
    }
}
