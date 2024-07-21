//
//  RickAndMortyCharactersApp.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import SwiftUI

@main
struct RickAndMortyCharactersApp: App {
    
    @StateObject private var characterVM = CharacterViewModel()
    @StateObject private var networkMonitor = NetworkMonitor()
    @StateObject private var filterMV = FilterViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CharactersView()
                ///Forced dark theme for the app
                    .preferredColorScheme(.dark)
            }
            .environmentObject(characterVM)
            .environmentObject(networkMonitor)
            .environmentObject(filterMV)
        }
    }
}
