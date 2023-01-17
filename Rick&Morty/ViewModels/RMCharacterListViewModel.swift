//
//  CharacterListViewModel.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/16/23.
//

import UIKit

final class RMCharacterListViewModel: NSObject {
    
    func fetchCharacters() {
        RMService.shared.execute(.listOfCharacters, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model.info.count))
                print(String(describing: model.results.first?.image ?? "None"))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}

extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCell.id, for: indexPath) as? RMCharacterCell else {
            fatalError()
        }
        let model = RMCharacterCollectionViewModel(name: "Michael", status: .alive, imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
