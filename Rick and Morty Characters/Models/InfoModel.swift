//
//  InfoModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation

struct InfoModel: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}
