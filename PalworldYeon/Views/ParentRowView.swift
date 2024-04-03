//
//  ParentRowView.swift
//  PalworldYeon
//
//  Created by yeon on 4/4/24.
//

import SwiftUI

struct ParentRowView: View {
    var motherName: String
    var fatherId: Int
    var palManager: PalManager

    var fatherName: String {
        palManager.pals.first { $0.id == fatherId }?.name ?? "Unknown"
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Mother: \(motherName)")
                    .font(.headline)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Father: \(fatherName)")
                    .font(.headline)
            }
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .frame(width: 30, height: 30)
        }
        .padding()
    }
}


