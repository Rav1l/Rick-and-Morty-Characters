//
//  SplashScreenView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import SwiftUI

struct LaunchView: View {
    
    var body: some View {
        VStack {
            ZStack {
                Image("rickAndMortyBackground")
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
