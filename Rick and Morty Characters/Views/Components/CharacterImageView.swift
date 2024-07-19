//
//  CharacterImageView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import Foundation
import SwiftUI

struct CharacterImageView: View {
    
    @StateObject var vm: CharacterImageViewModel
    
    init(character: CharacterModel) {
        _vm = StateObject(wrappedValue: CharacterImageViewModel(character: character))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "person.crop.circle.badge.exclamationmark")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    CharacterImageView(character: DeveloperPreview.instance.character)
        .preferredColorScheme(.dark)
}
