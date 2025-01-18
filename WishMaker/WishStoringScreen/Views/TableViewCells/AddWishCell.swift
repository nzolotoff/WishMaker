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
        static let textViewCorner: CGFloat = 12
        static let textViewTextColor: UIColor = .systemPink
        static let textViewFontSize: CGFloat = 16
        static let textViewBorderWidth: CGFloat = 1
        static let textViewPlaceholderOffset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0)
        
        static let addWishViewTrailingOffset: CGFloat = -1 * 10
        static let addWishViewTopOffset: CGFloat = 5
        static let addWishViewBottomOffset: CGFloat = -1 * 5
        static let addWishViewWidth: CGFloat = 85

        static let addWishTextViewTrailingOffset: CGFloat =  -1 * 5
        static let addWishTextViewLeadingOffset: CGFloat = 15
    }
    
    // MARK: - Static Fields
    static let reuseId: String = "AddWishCell"
    
    // MARK: - Fields
    private let addWishTextView: UITextView = UITextView()
    private let addWishView: AddWishView = AddWishView()
    
    // MARK: - Variables
    var addWish: ((String) -> Void)?
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        addWishViewTapRecognizer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        [addWishTextView, addWishView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        addWishTextView.layer.cornerRadius = Constants.textViewCorner
        addWishTextView.textColor = Constants.textViewTextColor
        addWishTextView.font = .systemFont(ofSize: Constants.textViewFontSize)
        addWishTextView.layer.borderWidth = Constants.textViewBorderWidth
        addWishTextView.layer.borderColor = UIColor.systemPink.cgColor
        addWishTextView.textContainerInset = Constants.textViewPlaceholderOffset

        NSLayoutConstraint.activate([
            addWishView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.addWishViewTrailingOffset),
            addWishView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.addWishViewTopOffset),
            addWishView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.addWishViewBottomOffset),
            addWishView.widthAnchor.constraint(equalToConstant: Constants.addWishViewWidth),
            
            addWishTextView.trailingAnchor.constraint(equalTo: addWishView.leadingAnchor, constant: Constants.addWishTextViewTrailingOffset),
            addWishTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.addWishTextViewLeadingOffset),
            addWishTextView.topAnchor.constraint(equalTo: addWishView.topAnchor),
            addWishTextView.bottomAnchor.constraint(equalTo: addWishView.bottomAnchor)
        ])
    }
    
    private func addWishViewTapRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addWishViewTapped))
        addWishView.addGestureRecognizer(tapGesture)
        addWishView.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    @objc private func addWishViewTapped() {
        guard let text = addWishTextView.text, !text.isEmpty else { return }
        addWish?(text)
        addWishTextView.text = ""
    }
}
