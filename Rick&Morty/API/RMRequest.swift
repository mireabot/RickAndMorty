//
//  RMRequest.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/8/23.
//

import Foundation

final class RMRequest {
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint: RMEndpoint
    private let path: [String]
    private let query: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !path.isEmpty {
            path.forEach({
                string += "/\($0)"
            })
        }
        
        if !query.isEmpty {
            string += "?"
            let argumentString = query.compactMap({
                guard let value = $0.value else { return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(endpoint: RMEndpoint, path: [String] = [], query: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.path = path
        self.query = query
    }
}

extension RMRequest {
    static let listOfCharacters = RMRequest(endpoint: .character)
}
