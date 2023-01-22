//
//  Extensions.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/16/23.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
