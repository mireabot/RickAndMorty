//
//  CharacterListViewModel.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/16/23.
//

import UIKit

protocol RMCharacterListViewModelDelegate: AnyObject {
    func didLoadCharacters()
    func didSelectCharacter(character: RMCharacter)
}

final class RMCharacterListViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let model = RMCharacterCollectionViewModel(name: character.name, status: character.status, imageURL: URL(string: character.image))
                cellViewModels.append(model)
            }
        }
    }
    
    private var isLoading = false
    
    private var cellViewModels: [RMCharacterCollectionViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    func fetchCharacters() {
        RMService.shared.execute(.listOfCharacters, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.results
                let info = model.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadCharacters()
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    public func fetchMoreCharacters() {
        isLoading = true
    }
    
    public var showMore: Bool {
        return apiInfo?.next != nil
    }
}

extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCell.id, for: indexPath) as? RMCharacterCell else {
            fatalError()
        }
        let model = cellViewModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character: character)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, showMore,
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionView.id, for: indexPath) as? RMFooterLoadingCollectionView
        else {
            fatalError("Unsupported ")
        }
        footer.start()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard showMore else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}

extension RMCharacterListViewModel : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard showMore, !isLoading else {
            return
        }
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollHeight = scrollView.frame.size.height
        
        if offset >= (contentHeight - scrollHeight - 120) {
            fetchMoreCharacters()
        }
    }
}
