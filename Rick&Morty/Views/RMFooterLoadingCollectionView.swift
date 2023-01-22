//
//  RMFooterLoadingCollectionView.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/22/23.
//

import UIKit
import SnapKit

class RMFooterLoadingCollectionView: UICollectionReusableView {
    static let id = "RMFooterLoadingCollectionView"
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        spinner.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
    }
    
    public func start() {
        spinner.startAnimating()
    }
}
