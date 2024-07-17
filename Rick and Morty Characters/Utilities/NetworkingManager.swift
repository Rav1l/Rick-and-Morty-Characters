//
//  NetworkingManager.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unkown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url): "Bad response from URL: \(url)"
            case .unkown: "Unkown erroe occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
           .subscribe(on: DispatchQueue.global(qos: .default))
           .tryMap { try handleURLResponse(output: $0, url: url) }
           .receive(on: DispatchQueue.main)
           .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(complition: Subscribers.Completion<Error>) {
        switch complition {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
