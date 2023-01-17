//
//  RMEpisode.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/8/23.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
