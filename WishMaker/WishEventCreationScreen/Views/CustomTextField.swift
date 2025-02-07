//
//  CustomTextField.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 28.01.2025.
//

import UIKit

final class CustomTextField: UIView {
    // MARK: - Constants
    enum Constants {
        // title label
        static let titleLabelFont: UIFont =  UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let titleLabelNumberOfLines: Int = 1
        static let titleLabelHeight: CGFloat = 18
        
        // text field
        static let textFieldLeftView: CGRect = CGRect(x: 0, y: 0, width: 12, height: 48)
        static let textFieldCorner: CGFloat = 16
        static let textFieldBorderWidth: CGFloat = 1
        static let textFieldOffsetTop: CGFloat = 8
        static let textFieldHeight: CGFloat = 52
        
        // self height
        static let selfHeight: CGFloat = 80
    }
    
    // MARK: - Fields
    private let titleLabel: UILabel = UILabel()
    
    // MARK: - Variables
    private var textField: UITextField = UITextField()

    // MARK: - Lyfecycle
    init(title: String, placeholder: String? = nil) {
        super.init(frame: .zero)
        configureUI(title: title, placeholder: placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Non private methods
    func getText() -> String {
        textField.text ?? " "
    }
    
    func setText(text: String) {
        textField.text = text
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }
    
    // MARK: - Configure UI
    private func configureUI(title: String, placeholder: String?) {
        configureTitle(title)
        configureTextField(placeholder)

        heightAnchor.constraint(equalToConstant: Constants.selfHeight).isActive = true
    }
    
    private func configureTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.textColor = .systemPink
        titleLabel.font = Constants.titleLabelFont
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight).isActive = true
    }
    
    private func configureTextField(_ placeholder: String?) {
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: Constants.textFieldLeftView)
        textField.textColor = .systemPink
        textField.placeholder = placeholder
        textField.layer.cornerRadius = Constants.textFieldCorner
        textField.layer.borderWidth = Constants.textFieldBorderWidth
        textField.layer.borderColor = UIColor.systemPink.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        
        addSubview(textField)
        textField.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: Constants.textFieldOffsetTop
        ).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
