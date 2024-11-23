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
        static let wrapColor: UIColor = .white
        static let wrapCorner: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    
    // MARK: - Fields
    private let wishLabel: UILabel = UILabel()
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Non Private Methods
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapCorner
        wrap.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrap.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.wrapOffsetV),
            wrap.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.wrapOffsetH)
            ])
        
        wrap.addSubview(wishLabel)
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wishLabel.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.wishLabelOffset),
        ])
    }
}
