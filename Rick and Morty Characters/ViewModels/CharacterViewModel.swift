//
//  CharacterViewModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation

final class CharacterViewModel: ObservableObject {
    
    @Published var allCharacters: [CharacterModel] = []
    @Published var canLoadNextPage: Bool = true
    @Published var isFinished: Bool = false
    @Published var error: Error?
    
    private let baseURL = "https://rickandmortyapi.com/api/character/?page="
    private var currentPage = 1
    
    init() {
        loadData()
    }
    ///Download data about characters form API
    @MainActor
    private func fetchData() async throws {
        do {
            guard let url = URL(string: baseURL + String(currentPage)),
                  canLoadNextPage == true else { throw NetworkingError.invalidURL }
            
            canLoadNextPage = false
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.serverError }
            
            guard let returnedResult = try? JSONDecoder().decode(Characters.self, from: data) else { throw NetworkingError.invalidData }
            
            isFinished = returnedResult.info.next == nil
            self.currentPage += 1
            self.allCharacters.append(contentsOf: returnedResult.results)
            canLoadNextPage = !isFinished
        } catch {
            self.error = error
        }
    }
    
    func loadData() {
        Task {
            try await fetchData()
        }
    }
}

