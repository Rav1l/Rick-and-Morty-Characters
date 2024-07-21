//
//  FilterViewModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import Foundation

final class FilterViewModel: ObservableObject {
    
    @Published var filterCharacters: [CharacterModel] = []
    @Published var error: Error?
    
    @Published var searchText: String = ""
    private var nextPage = 2
    private var pages = 1
    private var baseURL = "https://rickandmortyapi.com/api/character/?"
    
    
    ///Download data about characters form API
    @MainActor
    private func filterData() async throws {
        do {
            guard let url = URL(string: baseURL + "name=\(searchText)".lowercased()) else { throw NetworkingError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.serverError }
            
            guard let returnedResult = try? JSONDecoder().decode(Characters.self, from: data) else { throw NetworkingError.invalidData }
            self.error = nil
            self.pages = returnedResult.info.pages
            if returnedResult.info.pages >= 2  {
                self.nextPage = 2
            }
            self.filterCharacters = returnedResult.results
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    private func nextPageFetch() async throws {
        do {
            guard let url = URL(string: baseURL + "page=\(nextPage)&name=\(searchText)".lowercased()),
                  self.nextPage <= self.pages else { throw NetworkingError.invalidURL }
           
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.serverError }
            
            guard let returnedResult = try? JSONDecoder().decode(Characters.self, from: data) else { throw NetworkingError.invalidData }
            
            self.nextPage = self.nextPage <= returnedResult.info.pages ? (self.nextPage + 1) : 2
            self.filterCharacters.append(contentsOf: returnedResult.results)
        } catch {
            self.error = error
        }
    }
    
    func loadData() {
        Task {
            try await filterData()
        }
    }
    
    func loadNextPage() {
        Task {
            try await nextPageFetch()
        }
    }
}

