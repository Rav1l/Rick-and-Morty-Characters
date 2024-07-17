//
//  CharacterViewModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation
import Combine

class CharacterViewModel: ObservableObject {
    
    @Published var allCharacters: [CharacterModel] = []
    
    private let dataService = CharactersDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCharacters
            .sink { [weak self] returnedCharacters in
                self?.allCharacters = returnedCharacters
            }
            .store(in: &cancellables)
    }
}
