//
//  RMCharaterViewController.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/8/23.
//

import UIKit

final class RMCharaterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RMRequest(endpoint: .character, path: ["1"],query: [
            URLQueryItem(name: "name", value: "rick"),
            URLQueryItem(name: "status", value: "alive")
        ])
        print(request.url)
    }
}
