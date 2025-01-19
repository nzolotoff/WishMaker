//
//  Untitled.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 19.01.2025.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        addArrangedSubviews(views)
    }
}
