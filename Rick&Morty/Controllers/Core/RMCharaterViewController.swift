//
//  RMCharaterViewController.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/8/23.
//

import UIKit

final class RMCharaterViewController: UIViewController {
    
    private let charactersList = CharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        view.addSubview(charactersList)
        charactersList.delegate = self
        
        charactersList.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension RMCharaterViewController: CharacterListViewDelegate {
    func rmCharacterList(_ listView: CharacterListView, character: RMCharacter) {
        let model = RMCharacterDetailViewModel(character: character)
        let controller = RMCharacterDetailViewController(model: model)
        controller.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(controller, animated: true)
    }
}
