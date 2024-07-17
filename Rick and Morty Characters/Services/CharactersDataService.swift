//
//  CharactersDataService.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation
import Combine

class CharactersDataService {
    
    @Published var allCharacters: [CharacterModel] = []
    
    var characterSubscription: AnyCancellable?
    
    init() {
        getCharacters()
    }
    
    private func getCharacters() {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        characterSubscription = NetworkingManager.download(url: url)
            .decode(type: Characters.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCharacters in
                self?.allCharacters = returnedCharacters.results
                self?.characterSubscription?.cancel()
            })
    }
}
