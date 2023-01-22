//
//  CharacterListView.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/16/23.
//

import UIKit
import SnapKit

protocol CharacterListViewDelegate: AnyObject {
    func rmCharacterList(_ listView: CharacterListView, character: RMCharacter)
}
final class CharacterListView: UIView {
    //MARK: - Properties
    
    public weak var delegate: CharacterListViewDelegate?
    
    private let viewModel = RMCharacterListViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()
    
    private let charactersCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(RMCharacterCell.self, forCellWithReuseIdentifier: RMCharacterCell.id)
        cv.isHidden = true
        cv.alpha = 0
        cv.register(RMFooterLoadingCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionView.id)
        return cv
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(charactersCollection, spinner)
        layout()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setupCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func layout() {
        spinner.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
        
        charactersCollection.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupCollection() {
        charactersCollection.dataSource = viewModel
        charactersCollection.delegate = viewModel
    }
    
    //MARK: - Selectors
}

extension CharacterListView : RMCharacterListViewModelDelegate {
    func didLoadCharacters() {
        spinner.stopAnimating()
        charactersCollection.isHidden = false
        charactersCollection.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.charactersCollection.alpha = 1
        }
    }
    
    func didSelectCharacter(character: RMCharacter) {
        delegate?.rmCharacterList(self, character: character)
    }
}
