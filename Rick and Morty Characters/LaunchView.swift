//
//  SplashScreenView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import SwiftUI

struct LaunchView: View {
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack {
            ZStack {
                Image("rickAndmortyBackground")
                    .resizable()
                    .ignoresSafeArea()
                Image("rickAndMortyLogo")
                    .resizable()
                    .scaledToFit()
                    .padding([.leading, .trailing], 49)
            }
            
        }
    }
}

#Preview {
    LaunchView()
}
