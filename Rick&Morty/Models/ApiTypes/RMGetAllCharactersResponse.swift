//
//  RMGetAllCharactersResponse.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/16/23.
//

import UIKit

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [RMCharacter]
}
