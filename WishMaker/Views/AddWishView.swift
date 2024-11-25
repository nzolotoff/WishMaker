//
//  AddWishButton.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 25.11.2024.
//

import UIKit

class AddWishView: UIView {
    
    private let addLabel: UILabel = UILabel()
    private let iconImageView: UIImageView = UIImageView()
    private let myStack: UIStackView = UIStackView()

    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layer.borderWidth = 0.5
        layer.cornerRadius = 8
        
        addLabel.text = "Add"
        addLabel.textColor = .systemPink
        iconImageView.image = UIImage(systemName: "sparkles")
        iconImageView.tintColor = .systemPink
        [addLabel, iconImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            myStack.addArrangedSubview($0)
        }
        
        myStack.axis = .horizontal
        myStack.distribution = .equalSpacing
        myStack.spacing = 5
        myStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(myStack)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            myStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            myStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
