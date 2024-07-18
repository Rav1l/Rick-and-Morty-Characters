//
//  ContentView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import SwiftUI

///Main view
struct CharactersView: View {
    
    @EnvironmentObject private var vm: CharacterViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.allCharacters) { character in
                    NavigationLink(value: character) {
                        CharacterRowView(character: character)
                            .onAppear {
                                if character.id == vm.allCharacters.last?.id {
                                    
                                    vm.loadData()
                                }
                            }
                    }
                    .padding(.bottom, -3)
                }
                loadingIndicator
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { titel }
        .toolbarRole(.navigationStack)
        .navigationDestination(for: CharacterModel.self) { character in
            DetailView(character: character)
        }
    }
}

#Preview {
    NavigationStack {
        CharactersView()
            .preferredColorScheme(.dark)
    }
    .environmentObject(DeveloperPreview.instance.characterVM)
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
    
    private var loadingIndicator: some View {
        ProgressView()
            .scaleEffect(2)
            .padding(.top, 12)
    }
}
