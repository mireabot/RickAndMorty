//
//  RMService.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/8/23.
//

import Foundation

/// Primary API Service to get Rick&Morty data
final class RMService {
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Constructor
    private init() {}
    
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}
