//
//  EventSetupDateView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 29.01.2025.
//

import UIKit

protocol EventSetupDateViewDelegate: AnyObject {
    func cancelButtonWasTapped()
    func doneButtonWasTapped(currentDate: Date)
}

final class EventSetupDateView: UIView {
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

        // date picker
        static let datePickerOffsetLeading: CGFloat = 12
        static let datePickerOffsetTrailing: CGFloat = -1 * 20
    }

    // MARK: - Fileds
    private let datePicker: UIDatePicker = UIDatePicker()
    private let cancelButton: ColorButton = ColorButton(title: Constants.cancelButtonTitle)
    private let doneButton: ColorButton = ColorButton(title: Constants.doneButtonTitle)
    private let buttonsStack: UIStackView = UIStackView()
    
    // MARK: - Variables
    weak var delegate: EventSetupDateViewDelegate?
    
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
        configureDatePicker()
        configureButtonsStack()
    }
    
    private func configureDatePicker() {
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        datePicker.contentMode = .bottom
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = .current
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: topAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.datePickerOffsetLeading).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.datePickerOffsetTrailing).isActive = true
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
        buttonsStack.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: Constants.buttonsStackOffsetTop).isActive = true
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
            let currentDate = self?.datePicker.date
            self?.delegate?.doneButtonWasTapped(currentDate: currentDate ?? Date())
        }
    }
}
