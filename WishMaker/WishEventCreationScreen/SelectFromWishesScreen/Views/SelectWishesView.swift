//
//  SelectWishesView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 06.02.2025.
//

import UIKit

protocol SelectWishesViewDelegate: AnyObject {
    func cancelButtonWasTapped()
    func doneButtonWasTapped(wish: String)
    
    func getWishes() -> [String]
}

final class SelectWishesView: UIView {
    // MARK: - Constants
    enum Constants {
        // cancel button
        static let cancelButtonTitle: String = "Cancel"
        
        // done button
        static let doneButtonTitle: String = "Done"
        
        // buttons stack view
        static let buttonsStackSpacing: CGFloat = 12
        static let buttonsStackOffsetTop: CGFloat = 12
        static let buttonsStackOffsetLeading: CGFloat = 20
        static let buttonsStackOffsetTrailing: CGFloat = -1 * 20
        
        // wish picker
        static let numberOfComponents: Int = 1
        
    }
    // MARK: - Fields
    private let wishPicker: UIPickerView = UIPickerView()
    private let cancelButton: ColorButton = ColorButton(title: Constants.cancelButtonTitle)
    private let doneButton: ColorButton = ColorButton(title: Constants.doneButtonTitle)
    private let buttonsStack: UIStackView = UIStackView()
    
    // MARK: - Variables
    weak var delegate: SelectWishesViewDelegate?
    
    // MARK: - Lyfecycle
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        backgroundColor = .white
        configureWishPicker()
        configureButtonsStack()
    }
    
    private func configureWishPicker() {
        wishPicker.dataSource = self
        wishPicker.delegate = self
        wishPicker.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(wishPicker)
        wishPicker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        wishPicker.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func configureButtonsStack() {
        cancelButton.button.backgroundColor = .systemGray
        doneButton.button.backgroundColor = .systemPink
        
        setActionForCancelButton()
        setActionForDoneButton()
        
        for button in [cancelButton, doneButton] {
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = Constants.buttonsStackSpacing
        buttonsStack.addArrangedSubviews(cancelButton, doneButton)
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonsStack)
        buttonsStack.topAnchor.constraint(equalTo: wishPicker.bottomAnchor, constant: Constants.buttonsStackOffsetTop).isActive = true
        buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.buttonsStackOffsetLeading).isActive = true
        buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.buttonsStackOffsetTrailing).isActive = true
    }
    
    // MARK: - Actions
    private func setActionForCancelButton() {
        cancelButton.action = { [weak self] in
            self?.delegate?.cancelButtonWasTapped()
        }
    }
    
    private func setActionForDoneButton() {
        doneButton.action = { [weak self] in
            let selectedIndex = self?.wishPicker.selectedRow(inComponent: 0)
            let currentWish = self?.delegate?.getWishes()[selectedIndex ?? 0]
            self?.delegate?.doneButtonWasTapped(wish: currentWish ?? "")
        }
    }
}

// MARK: - UIPickerViewDataSource
extension SelectWishesView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let numberOfWishes = self.delegate?.getWishes().count
        return  numberOfWishes ?? 0
    }
}

// MARK: - UIPickerViewDelegate
extension SelectWishesView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result = self.delegate?.getWishes()
        return result?[row] ?? ""
    }
}
