//
//  CustomButton.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.11.2024.
//

import UIKit

class CustomButton: UIButton {
    // MARK: - Constants
    enum Constants {
        static let corner: CGFloat = 12
        static let height: Double = 42
        
        static let fatalError: String = "init(coder:) has not been implemented"
    }

    // MARK: - Lyfecycle
    init(title: String) {
        super.init(frame: .zero)
        configureButton(title: title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    // MARK: - Private methods
    private func configureButton(title: String) {
        backgroundColor = .black
        layer.cornerRadius = Constants.corner
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
    }
}
