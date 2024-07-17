//
//  EpisodeModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation

struct Episodes: Codable {
    let info: InfoModel
    let results: [EpisodeModel]
}

struct EpisodeModel: Codable, Identifiable {
    let id: Int
    let name: String
}
