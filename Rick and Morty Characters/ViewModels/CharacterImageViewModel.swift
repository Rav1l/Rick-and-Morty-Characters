//
//  CharacterImageViewModel.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import Foundation
import SwiftUI

//Caching images
final class CharacterImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private let character: CharacterModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "character_images"
    private let imageName: String
    
    init(character: CharacterModel) {
        self.character = character
        self.isLoading = true
        self.imageName = String(character.id)
        getCharacterImage()
    }
    
    ///Get image if image save form File Manager, else download image from API
    private func getCharacterImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            loadImage()
        }
    }
    ///Download image from API used async/await
    @MainActor
    private func downloadCharacetrImage() async throws {
        do {
            guard let url = URL(string: character.image) else  { throw NetworkingError.invalidURL }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.serverError }
            
            guard let returnedImage = UIImage(data: data) else { throw NetworkingError.invalidData }
            self.image = returnedImage
            self.fileManager.saveImage(image: returnedImage, imageName: self.imageName, folderName: self.folderName)
        } catch {
            self.error = error
        }
    }
    ///Add asyn function downloading image to task
    func loadImage() {
        Task {
            try await downloadCharacetrImage()
        }
    }
}

