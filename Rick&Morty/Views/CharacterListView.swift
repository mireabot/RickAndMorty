//
//  CharacterListView.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/16/23.
//

import UIKit
import SnapKit

final class CharacterListView: UIView {
    //MARK: - Properties
    private let viewModel = RMCharacterListViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()
    
    private let charactersCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(RMCharacterCell.self, forCellWithReuseIdentifier: RMCharacterCell.id)
        cv.isHidden = true
        cv.alpha = 0
        
        return cv
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(charactersCollection, spinner)
        layout()
        spinner.startAnimating()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.spinner.stopAnimating()
            self.charactersCollection.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.charactersCollection.alpha = 1
            }
        }
    }
    
    //MARK: - Selectors
}

