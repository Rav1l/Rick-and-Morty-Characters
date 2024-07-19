//
//  ContentView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import SwiftUI

///Main view
struct CharactersView: View {
    
    @EnvironmentObject private var characterVM: CharacterViewModel
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    
    var body: some View {
        if networkMonitor.isConnected {
            ScrollView {
                LazyVStack {
                        rowsAllCharacters
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { titel }
            .toolbarRole(.navigationStack)
            .navigationDestination(for: CharacterModel.self) { character in
                DetailView(character: character)
            }
        }  else {
            NetworkErrorView()
        }
    }
}

#Preview {
    NavigationStack {
        CharactersView()
            .preferredColorScheme(.dark)
    }
    .environmentObject(DeveloperPreview.instance.characterVM)
    .environmentObject(NetworkMonitor())
}

extension CharactersView {
    ///Titel of navigationStack
    private var titel: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("Rick & Morty Characters")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
        }
    }
    ///ProgressView loading circular indiactor
    private var loadingIndicator: some View {
        ProgressView()
            .scaleEffect(2)
            .padding(.top, 12)
    }
    
    private var rowsAllCharacters: some View {
        ForEach(characterVM.allCharacters) { character in
            NavigationLink(value: character) {
                CharacterRowView(character: character)
                ///Pagination list
                    .onAppear {
                        if character.id == characterVM.allCharacters.last?.id {
                            characterVM.loadData()
                        }
                    }
            }
            .padding(.bottom, -3)
            ///Hardcode loading indicator view
            if character == characterVM.allCharacters.last && character.id != 826 {
                loadingIndicator
            }
        }
    }
}

