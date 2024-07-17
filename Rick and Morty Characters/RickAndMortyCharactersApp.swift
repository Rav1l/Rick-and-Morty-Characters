//
//  RickAndMortyCharactersApp.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import SwiftUI

@main
struct RickAndMortyCharactersApp: App {
    
    @StateObject private var vm = CharacterViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CharactersView()
                ///dark theme for the app
                    .preferredColorScheme(.dark)
            }
            .environmentObject(vm)
        }
    }
}
