//
//  DetailView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 18.07.2024.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject private var episodeVM: EpisodesViewModel
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    
    @Environment(\.dismiss) var dismiss
    
    let character: CharacterModel
    
    init(character: CharacterModel) {
        self.character = character
        _episodeVM = StateObject(wrappedValue: EpisodesViewModel(character: character))
    }
    
    var body: some View {
        ScrollView {
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
        }
        .scrollBounceBehavior(.basedOnSize)
        .scrollIndicators(.hidden)
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
    .environmentObject(NetworkMonitor())
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
        CharacterImageView(character: character)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .scaledToFit()
    }
    ///Character status information
    private var status: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(character.status.rawValue)
                    .fontWeight(.semibold)
                    .padding([.top, .bottom], 5)
                Spacer()
            }
            Spacer()
        }
        .background(in: RoundedRectangle(cornerRadius: 15))
        .backgroundStyle(Color.theme.statusTextColor(character: character))
    }
    ///Strign of episodes names
    private var episodesNames: String {
        var names = ""
        episodeVM.episodes.forEach {
            names += $0.name
            if episodeVM.episodes.last?.name != $0.name {
                names += ", "
            }
        }
        return names
    }
    
    ///Information about character
    private var info: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(try! AttributedString(
                    markdown: "**Specise:** \(character.species)"))
                Text(try! AttributedString(
                    markdown: "**Gender:** \(character.gender.rawValue)"))
                Text(try! AttributedString(
                    markdown: "**Eposides:** \(episodesNames)"))
                Text(try! AttributedString(
                    markdown: "**Last known location:** \(character.location.name)"))
            }
            Spacer()
        }
    }
}
