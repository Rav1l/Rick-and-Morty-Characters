//
//  DetailView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 18.07.2024.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let character: CharacterModel
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    image
                    status
                        .padding(.top, 5)
                    info
                        .padding(.top, 10)
                }
                .padding(15)
            }
            .background(in: RoundedRectangle(cornerRadius: 25.0))
            .backgroundStyle(Color.theme.rowBackground)
            .padding([.leading, .trailing], 23)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton; title }
    }
}

#Preview {
    NavigationStack {
        DetailView(character: DeveloperPreview.instance.character)
            .preferredColorScheme(.dark)
    }
}

extension DetailView {
    ///NavigationStack  back button
    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                ZStack {
                    Rectangle()
                        .frame(width: 24, height: 24)
                        .opacity(0)
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 9, height: 18)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.theme.text)
                }
            })
        }
    }
    ///Titel of navigationStack
    private var title: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(self.character.name)
                .font(.title)
                .fontWeight(.bold)
        }
    }
    ///Character image
    private var image: some View {
        AsyncImage(url: URL(string: character.image), content: { image in
            image.resizable()
        }, placeholder: {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        })
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .scaledToFit()
    }
    ///Character status information
    private var status: some View {
        RoundedRectangle(cornerRadius: 15.0)
            .frame(height: 42)
            .foregroundStyle(Color.theme.statusTextColor(character: character))
            .overlay {
                Text(character.status.rawValue)
                    .fontWeight(.semibold)
            }
    }
    ///String all number episodes with character
    private var episodes: String {
        var string = ""
        let episodes = character.episode.map { $0.components(separatedBy: "/").last ?? ""}
        for episode in episodes {
            string.append(episode)
            if episodes.last != episode {
                string += ", "
            }
        }
        return string
    }
    ///Information about character
    private var info: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Specise:")
                    .fontWeight(.semibold)
                Text(character.species)
                Spacer()
            }
            HStack {
                Text("Gendet:")
                    .fontWeight(.semibold)
                Text(character.gender.rawValue)
            }
            HStack {
                Text("Episodes:")
                    .fontWeight(.semibold)
                Text(episodes)
                    .frame(maxWidth: 250, alignment: .leading)
            }
            HStack {
                Text("Last known location:")
                    .fontWeight(.semibold)
                    .frame(minWidth: 170, alignment: .leading)
                Text(character.location.name)
                    .frame(maxWidth: 150, alignment: .leading)
            }
        }
    }
}
