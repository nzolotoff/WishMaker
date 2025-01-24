//
//  WrittenWishCell.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 22.11.2024.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    // MARK: - Static Fields
    static let reuseId: String = "WrittenWishCell"
    
    // MARK: - Constants
    enum Constants {
        static let wrapViewColor: UIColor = .clear
        static let wrapViewCorner: CGFloat = 8
        static let wrapViewOffsetH: CGFloat = 4
        static let wrapViewOffsetV: CGFloat = 12
        static let wishLabelOffsetLeading: CGFloat = 12
        static let wishLabelOffsetTop: CGFloat = 8
        static let wishLabelOffsetTrailing: CGFloat = -1 * 12
    }
    
    // MARK: - Fields
    private let wishLabel: UILabel = UILabel()
    private let wrapView: UIView = UIView()
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        wrapView.backgroundColor = Constants.wrapViewColor
        wrapView.layer.cornerRadius = Constants.wrapViewCorner
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(wrapView)
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.wrapViewOffsetV),
            wrapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.wrapViewOffsetH),
            wrapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.wrapViewOffsetH),
            wrapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.wrapViewOffsetV)
            ])
        
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        wishLabel.textColor = .systemPink
        
        wrapView.addSubview(wishLabel)
        NSLayoutConstraint.activate([
            wishLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.wishLabelOffsetLeading),
            wishLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: Constants.wishLabelOffsetTop),
            wishLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: Constants.wishLabelOffsetTrailing),
            wishLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor)
        ])
    }
}
