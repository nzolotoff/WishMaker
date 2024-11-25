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
            
        static let textViewLeadingOffset: CGFloat = 10
        static let textViewTrailingOffset: CGFloat = -1 * 100
        static let textViewTopOffset: CGFloat = 10
        static let textViewHeight: CGFloat = 60
        
        static let addWishViewLeadingOffset: CGFloat = 10
        static let addWishButtonTopOffset: CGFloat = 25
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
            addSubview($0)
        }
        
        addWishTextView.layer.cornerRadius = Constants.textViewCorner
        addWishTextView.textColor = Constants.textViewTextColor
        addWishTextView.font = .systemFont(ofSize: Constants.textViewFontSize)
        addWishTextView.layer.borderWidth = Constants.textViewBorderWidth
        
        NSLayoutConstraint.activate([
            addWishTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textViewLeadingOffset),
            addWishTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.textViewTrailingOffset),
            addWishTextView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.textViewTopOffset),
            addWishTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            
            addWishView.leadingAnchor.constraint(equalTo: addWishTextView.trailingAnchor, constant: Constants.addWishViewLeadingOffset),
            addWishView.centerYAnchor.constraint(equalTo: addWishTextView.centerYAnchor),
            addWishView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            addWishView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
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
