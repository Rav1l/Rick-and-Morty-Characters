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
    @EnvironmentObject private var filterVM: FilterViewModel
    
    var body: some View {
        if networkMonitor.isConnected {
            ScrollView {
                FilterBarView(searchText: $filterVM.searchText)
                LazyVStack {
                    if filterVM.searchText.isEmpty && filterVM.gender.isEmpty && filterVM.status.isEmpty {
                        rowsAllCharacters
                    } else if filterVM.error?.localizedDescription == NetworkingError.serverError.localizedDescription {
                        NothingFoundView()
                    } else {
                        rowsFilterCharacters
                    }
                }
            }
            .onChange(of: filterVM.searchText, { oldValue, newValue in
                filterVM.loadData()
            })
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
    .environmentObject(DeveloperPreview.instance.filterVM)
}

//MARK: Extensions
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
    
    ///List of all characters
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
    
    ///List of filtered characters
    private var rowsFilterCharacters: some View {
        ForEach(filterVM.filterCharacters) { character in
            NavigationLink(value: character) {
                CharacterRowView(character: character)
                ///Pagination list
                    .onAppear {
                        if character.id == filterVM.filterCharacters.last?.id {
                            filterVM.loadNextPage()
                        }
                    }
            }
            .padding(.bottom, -3)
        }
    }
}

