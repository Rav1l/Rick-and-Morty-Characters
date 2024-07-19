//
//  NothingFoundView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import SwiftUI

struct NothingFoundView: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    Text("No matches found")
                        .font(.title2)
                        .bold()
                    Text("Please try another filters")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                }
            }
            .padding([.top, .bottom, .trailing,], 40)
            .background(Color.theme.rowBackground)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            VStack {
                HStack {
                    Image("nothingFound")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .padding(.leading, -15)
                        .padding(.bottom, 180)
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    NothingFoundView()
        .preferredColorScheme(.dark)
}
