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
    @Published var status: String = ""
    @Published var gender: String = ""
    
    ///Properties used in filterSheetView
    @Published var isDead: Bool = false
    @Published var isAlive: Bool = false
    @Published var isStatusUnknown: Bool = false
    @Published var isFemale: Bool = false
    @Published var isMale: Bool = false
    @Published var isGenderless: Bool = false
    @Published var isGenderUnknown: Bool = false
    
    private var currentPage = 2
    private var pages = 1
    private var url: String {
        "https://rickandmortyapi.com/api/character/?name=\(searchText)&status=\(status)&gender=\(gender)".lowercased()
    }
    private var nextUrl: String {
        "https://rickandmortyapi.com/api/character/?page=\(currentPage)&name=\(searchText)&status=\(status)&gender=\(gender)".lowercased()
    }
    
    
    ///Download data about characters form API
    @MainActor
    private func filterData() async throws {
        do {
            guard let url = URL(string: url) else { throw NetworkingError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.serverError }
            
            guard let returnedResult = try? JSONDecoder().decode(Characters.self, from: data) else { throw NetworkingError.invalidData }
            self.error = nil
            self.pages = returnedResult.info.pages
            self.filterCharacters = returnedResult.results
        } catch {
            self.error = error
        }
    }
    
    func loadData() {
        Task {
            try await filterData()
        }
    }
    
    @MainActor
    private func nextPageFetch() async throws {
        do {
            guard let url = URL(string: nextUrl),
                  self.currentPage <= self.pages else { throw NetworkingError.invalidURL }
           
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.serverError }
            
            guard let returnedResult = try? JSONDecoder().decode(Characters.self, from: data) else { throw NetworkingError.invalidData }
            
            self.currentPage = self.currentPage <= self.pages ? (self.currentPage + 1) : 2
            self.filterCharacters.append(contentsOf: returnedResult.results)
        } catch {
            self.error = error
        }
    }
    
    func loadNextPage() {
        Task {
            try await nextPageFetch()
        }
    }
    
    func allSelectFalse() {
       self.isDead = false
       self.isAlive = false
       self.isStatusUnknown = false
       self.isFemale = false
       self.isMale = false
       self.isGenderless = false
       self.isGenderUnknown = false
   }
}

