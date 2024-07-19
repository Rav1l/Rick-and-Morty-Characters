//
//  EpisodesViewModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import Foundation
import SwiftUI
//TODO: get Sinlgle episode fetch
final class EpisodesViewModel: ObservableObject {
    
    @Published var episodes: [EpisodeModel] = []
    @Published var error: Error?
    
    private let character: CharacterModel
    
    private let baseURL = "https://rickandmortyapi.com/api/episode/"
    private var episodesIds: String {
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
    
    init(character: CharacterModel) {
        self.character = character
        self.loadData()
    }
    
    ///Download data about characters form API
    @MainActor
    private func fetchData() async throws {
        do {
            guard let url = URL(string: baseURL + episodesIds) else { throw NetworkingError.invalidURL }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.serverError }
            
            ///Decode from JSON if returned multiple episodes
            if self.character.episode.count > 1 {
                guard let returnedEpisodes = try? JSONDecoder().decode([EpisodeModel].self, from: data) else { throw NetworkingError.invalidData }
                self.episodes = returnedEpisodes
                
            } else if self.character.episode.count == 1 {
                ///Decode from JSON if returned a single episode
                guard let returnedEpisode = try? JSONDecoder().decode(EpisodeModel.self, from: data) else { throw NetworkingError.invalidData }
                self.episodes.append(returnedEpisode)
            }
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
