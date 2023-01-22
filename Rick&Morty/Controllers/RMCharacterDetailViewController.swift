//
//  RMCharacterDetailViewController.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/22/23.
//

import UIKit
import SnapKit

class RMCharacterDetailViewController: UIViewController {
    //MARK: - Properties
    private let model: RMCharacterDetailViewModel
    
    //MARK: - Lifecycle
    
    init(model: RMCharacterDetailViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = model.title
    }
    
    //MARK: - Helpers
    
    
    //MARK: - Selectors
}


