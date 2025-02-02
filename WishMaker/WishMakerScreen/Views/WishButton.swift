//
//  WishButton.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 18.01.2025.
//

import UIKit

class WishButton: UIView, TitleColorSettable {
    // MARK: - Constants
    enum Constants {
        static let wishButtonCorner: CGFloat = 20
        static let wishButtonHeight: CGFloat = 52
    }
    
    // MARK: - Variables
    var action: (() -> Void)?
    
    // MARK: - Fields
    let button: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    init(title: String, titleColor: UIColor = .systemPink, backGroundColor: UIColor = .white) {
        super.init(frame: .zero)
        configureWishButton(title: title, titleColor: titleColor, backGroundColor: backGroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureWishButton(title: String, titleColor: UIColor, backGroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backGroundColor
        button.layer.cornerRadius = Constants.wishButtonCorner
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(wishButtonWasTapped), for: .touchUpInside)
        
        addSubview(button)
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: Constants.wishButtonHeight).isActive = true
    }
    
    // MARK: - Actions
    @objc private func wishButtonWasTapped() {
        action?()
    }
}
