//
//  RMLocation.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/8/23.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimensions: String
    let residents: [String]
    let url: String
    let created: String
}
