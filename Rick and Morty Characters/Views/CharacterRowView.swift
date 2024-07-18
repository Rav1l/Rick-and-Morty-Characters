//
//  CharacterRowView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import SwiftUI
///Row of ScroolView in CharacterView
struct CharacterRowView: View {
    
    let character: CharacterModel
    
    var body: some View {
        HStack {
            image
            information
            Spacer()
        }
        .frame(height: 90)
        .background(Color.theme.rowBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding([.leading, .trailing], 10)
    }
}

#Preview {
    CharacterRowView(character: DeveloperPreview.instance.character)
        .preferredColorScheme(.dark)
}

extension CharacterRowView {
    ///Async download and setting image
    private var image: some View {
        AsyncImage(url: URL(string: character.image), content: { image in
            image.resizable()
        }, placeholder: {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        })
        .scaledToFill()
        .frame(width: 84, height: 64)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.leading, 10)
    }
    ///Information about character
    private var information: some View {
        VStack(alignment:.leading, spacing: 7) {
            ///Character's name
            Text(character.name)
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(1)
            ///Character's status
            HStack(spacing: 3) {
                Text(character.status.rawValue)
                    .foregroundStyle(Color.theme.statusTextColor(character: character))
                Text("• " + character.species)
            }
            .font(.caption)
            .fontWeight(.semibold)
            ///Character's gender
            Text(character.gender.rawValue)
                .font(.caption)
        }
        .foregroundStyle(Color.theme.text)
    }
}
