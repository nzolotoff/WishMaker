//
//  AddWishCell.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 23.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        static let textViewCorner: CGFloat = 8
        static let textViewTextColor: UIColor = .systemPink
        static let textViewFontSize: CGFloat = 16
        static let textViewBorderWidth: CGFloat = 0.5
        
        static let addWishButtonImageName: String = "sparkles"
        
        static let textViewLeadingOffset: CGFloat = 10
        static let textViewTrailingOffset: CGFloat = -1 * 50
        static let textViewTopOffset: CGFloat = 10
        static let textViewHeight: CGFloat = 60
        
        static let addWishButtonLeadingOffset: CGFloat = 10
        static let addWishButtonTopOffset: CGFloat = 25
        static let addWishButtonWidth: CGFloat = 30
        static let addWishButtonHeight: CGFloat = 30
    }
    
    // MARK: - Static Fields
    static let reuseId: String = "AddWishCell"
    
    // MARK: - Fields
    private let addWishTextView: UITextView = UITextView()
    private let addWishButton: UIButton = UIButton()
    
    // MARK: - Variables
    var addWish: ((String) -> Void)?
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        [addWishTextView, addWishButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)}
        
        addWishTextView.layer.cornerRadius = Constants.textViewCorner
        addWishTextView.textColor = Constants.textViewTextColor
        addWishTextView.font = .systemFont(ofSize: Constants.textViewFontSize)
        addWishTextView.layer.borderWidth = Constants.textViewBorderWidth
        
        addWishButton.setImage((UIImage(systemName: Constants.addWishButtonImageName)), for: .normal)
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addWishTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textViewLeadingOffset),
            addWishTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.textViewTrailingOffset),
            addWishTextView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.textViewTopOffset),
            addWishTextView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            
            addWishButton.leadingAnchor.constraint(equalTo: addWishTextView.trailingAnchor, constant: Constants.addWishButtonLeadingOffset),
            addWishButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.addWishButtonTopOffset),
            addWishButton.widthAnchor.constraint(equalToConstant: Constants.addWishButtonWidth),
            addWishButton.heightAnchor.constraint(equalToConstant: Constants.addWishButtonHeight)
        ])
        
    }
    
    // MARK: - Actions
    @objc private func addWishButtonTapped() {
        guard let text = addWishTextView.text, !text.isEmpty else { return }
        addWish?(text)
        addWishTextView.text = ""
    }

}
