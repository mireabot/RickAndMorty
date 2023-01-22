//
//  RMCharacterCollectionViewModel.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/16/23.
//

import UIKit

final class RMCharacterCollectionViewModel {
    public let name: String
    private let status: RMCharacterStatus
    private let imageURL: URL?
    
    init(name: String, status: RMCharacterStatus, imageURL: URL?) {
        self.name = name
        self.status = status
        self.imageURL = imageURL
    }
    
    public var characterStatusText: String {
        return "Status: \(status.text)"
    }
    
    public func fecthImage(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
