//
//  AddWishButton.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 25.11.2024.
//

import UIKit

class AddWishView: UIView {
    // MARK: - Constants
    enum Constants {
        static let viewCorner: CGFloat = 12
        
        static let addLabelText: String = "Add"
        static let iconImageName: String = "sparkles"
        
        static let stackSpacing: CGFloat = 5
        
        static let iconImageHeight: CGFloat = 24
        static let iconImageWidth: CGFloat = 24
    }
    
    // MARK: - Fields 
    private let addLabel: UILabel = UILabel()
    private let iconImageView: UIImageView = UIImageView()
    private let myStack: UIStackView = UIStackView()

    // MARK: - Lyfecycle
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        layer.cornerRadius = Constants.viewCorner
        backgroundColor = .systemPink
        
        addLabel.text = Constants.addLabelText
        addLabel.textColor = .white
        iconImageView.image = UIImage(systemName: Constants.iconImageName)
        iconImageView.tintColor = .white
        [addLabel, iconImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            myStack.addArrangedSubview($0)
        }
        
        myStack.axis = .horizontal
        myStack.distribution = .equalSpacing
        myStack.spacing = Constants.stackSpacing
        myStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(myStack)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconImageWidth),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconImageHeight),
            
            myStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            myStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
