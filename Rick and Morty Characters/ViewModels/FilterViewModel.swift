//
//  FilterViewModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import Foundation

final class FilterViewModel: ObservableObject {
    
    @Published var filterCharacters: [CharacterModel] = []
    @Published var canLoadNextPage: Bool = true
    @Published var isFinished: Bool = false
    @Published var error: Error?
    
    @Published var searchText: String = ""
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    
    private var currentPage = 1
    
    init() {
    }
    ///Download data about characters form API
    @MainActor
     func filter() async throws {
        do {
            guard let url = URL(string: baseURL) else { throw NetworkingError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.serverError }
            
            guard let returnedResult = try? JSONDecoder().decode(Characters.self, from: data) else { throw NetworkingError.invalidData }
 
            self.filterCharacters = returnedResult.results
        } catch {
            self.error = error
        }
    }
}

