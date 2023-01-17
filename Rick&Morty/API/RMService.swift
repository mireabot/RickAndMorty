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
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            // Decode response
            do {
                let json = try JSONDecoder().decode(type.self, from: data)
                completion(.success(json))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}
