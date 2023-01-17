//
//  CharacterCell.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/16/23.
//

import UIKit
import SnapKit

final class RMCharacterCell: UICollectionViewCell {
    //MARK: - Properties
    static let id = "RMCharacterCell"
    
    private let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Rick"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let characterStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Alive"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubViews(characterImage, characterNameLabel, characterStatusLabel)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func layout() {
        characterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(characterNameLabel.snp.top).offset(-3)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(characterStatusLabel.snp.top).offset(-3)
        }
        
        characterStatusLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-3)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
        characterNameLabel.text = nil
        characterStatusLabel.text = nil
    }
    
    public func configure(with model: RMCharacterCollectionViewModel) {
        characterNameLabel.text = model.name
        characterStatusLabel.text = model.characterStatusText
        model.fecthImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.characterImage.image = image
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    //MARK: - Selectors
}

