//
//  AddWishCell.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 23.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
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
    
    // MARK: - Non Private Methods
    func configureButton(with buttonIcon: UIImage) {
        addWishButton.setImage(buttonIcon, for: .normal)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        [addWishTextView, addWishButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)}
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
       
        NSLayoutConstraint.activate([
            addWishTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            addWishTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            addWishTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            addWishTextView.heightAnchor.constraint(equalToConstant: 80),
            
            addWishButton.leadingAnchor.constraint(equalTo: addWishTextView.trailingAnchor, constant: 10),
            addWishButton.topAnchor.constraint(equalTo: addWishButton.topAnchor),
            addWishButton.widthAnchor.constraint(equalToConstant: 30),
            addWishButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    // MARK: - Actions
    @objc private func addWishButtonTapped() {
        guard let text = addWishTextView.text, !text.isEmpty else { return }
        addWish?(text)
        addWishTextView.text = ""
    }

}
