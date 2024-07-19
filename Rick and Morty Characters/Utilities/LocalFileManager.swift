//
//  LocalFileManager.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import Foundation
import SwiftUI
///Caching images in File Manager
final class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() { }
    ///Save the image a custom folder  in the File Manager
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        ///Create folder
        createFolderIfNeed(folderName: folderName)
        ///Get path for image
        guard let data = image.jpegData(compressionQuality: 1.0),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        ///Save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. Image name: \(imageName). \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
        FileManager.default.fileExists(atPath: url.path()) else { return nil }
        return UIImage(contentsOfFile: url.path())
    }
    
    ///Create folder before call getURLForFolder(folderName: String) -> URL? ( get URL of this folder)
    private func createFolderIfNeed(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating directory. Folder name: \(folderName). \(error)")
            }
        }
    }
    ///Get URL for the custom folder with saving images
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appending(path: folderName)
    }
    ///Get URL saving image inside the custom folder
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appending(path: imageName + ".jpeg")
    }
    
}
