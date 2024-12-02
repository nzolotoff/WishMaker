//
//  CustomButton.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.11.2024.
//

import UIKit

class ColorButton: UIView {
    // MARK: - Constants
    enum Constants {
        static let corner: CGFloat = 12
        static let height: Double = 42
        static let width: Double = 120
        
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Properties
    var action: (() -> Void)?
    
    // MARK: - Fields
    let button: UIButton = UIButton(type: .system)

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
        button.backgroundColor = .black
        button.layer.cornerRadius = Constants.corner
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc private func buttonWasTapped() {
        action?()
    }
}
