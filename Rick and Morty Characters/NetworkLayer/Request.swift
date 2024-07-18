//
//  Request.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation

final class Request {
    
    private let baseURL = "https://rickandmortyapi.com/api"
    private let resource: Resources
    private let queryParameters: [URLQueryItem]
    
    ///Make string url for the api request
    private var urlString: String {
        var url = baseURL
        url += "/"
        url += resource.rawValue

        if !queryParameters.isEmpty {
            url += "?"
            let queries = queryParameters.compactMap {
                guard  let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            
            url += queries
        }
        return url
    }
    
    public var url: URL? {
        URL(string: urlString)
    }
    
    public init(resource: Resources, queryParameters: [URLQueryItem] = []) {
        self.resource = resource
        self.queryParameters = queryParameters
    }
    
    
}

