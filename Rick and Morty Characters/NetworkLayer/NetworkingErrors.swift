//
//  NetworkingErrors.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 18.07.2024.
//

import Foundation

enum NetworkingError: Error, LocalizedError {
    case invalidURL
    case serverError
    case invalidData
    case unkown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL was invaled. Please try again later."
        case .serverError:
            return "There was an error with the server. Please ry again later."
        case .invalidData:
            return "The returned data is invalid. Please ry again later"
        case .unkown(let error):
            return error.localizedDescription
        }
    }
}
