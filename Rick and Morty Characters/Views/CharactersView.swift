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
            ForEach(vm.allCharacters) { character in
                CharacterRowView(character: character)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { titel }
        .toolbarRole(.navigationStack)
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
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.bottom, 20)
        }
    }
    
}
