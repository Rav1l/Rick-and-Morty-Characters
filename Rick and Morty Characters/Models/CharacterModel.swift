//
//  CharacterModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation

struct Characters: Codable {
    let info: InfoModel
    let results: [CharacterModel]
}

struct CharacterModel: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let status: Status
    let species, type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.name)
        hasher.combine(self.species)
        hasher.combine(self.gender)
        hasher.combine(self.origin)
        hasher.combine(self.location)
        hasher.combine(self.image)
        hasher.combine(self.episode)
        hasher.combine(self.url)
        hasher.combine(self.created)
    }
    
}

struct Location: Codable, Hashable {
    let name: String
    let url: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
}

@frozen enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

@frozen enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}
