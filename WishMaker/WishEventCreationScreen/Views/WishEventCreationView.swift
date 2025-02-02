//
//  WishEventCreationView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 28.01.2025.
//

import UIKit

protocol WishEventCreationViewDelegate: AnyObject {
    func closeButtonWasTapped()
    func textFieldDateWasTapped(currentTextField: UITextField)
}

class WishEventCreationView: UIView {
    // MARK: - Constants
    enum Constants {
        // screen title label
        static let screenTitleLabelText: String = "Create event here!"
        static let screenTitleLabelNumberOfLines: Int = 1
        static let screenTitleLabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let screenTitleLabelOffsetTop: CGFloat = 26
        
        // close button
        static let closeButtonImage: UIImage? = UIImage(systemName: "xmark.circle")
        static let closeButtonOffsetTop: CGFloat = 24
        static let closeButtonOffsetTrailing: CGFloat = -1 * 20
        
        // event stack view (textfields)
        static let eventStackViewSpacing: CGFloat = 24
        static let eventStackViewOffsetTop: CGFloat = 32
        static let eventStackViewOffsetLeading: CGFloat = 20
        static let eventStackViewOffsetTrailing: CGFloat = -1 * 20

        // create event button
        static let createEventButtonOffsetTop: CGFloat = 24
    }
    
    // MARK: - Fields
    private let screenTitleLabel: UILabel = UILabel()
    private let closeButton: UIButton = UIButton(type: .system)
    private let eventTitleTextField: CustomTextField = CustomTextField(title: "Title", placeholder: "Enter event title here..")
    private let eventDescriptionTextField: CustomTextField = CustomTextField(title: "Description", placeholder: "Type here something..")
    private let eventStartDateTextField: CustomTextField = CustomTextField(title: "Start date", placeholder: "Tap to set start date")
    private let eventEndDateTextField: CustomTextField = CustomTextField(title: "End date", placeholder: "Tap to set end date")
    private let eventStackView: UIStackView = UIStackView()
    private let createEventButton: WishButton = WishButton(title: "Create event", titleColor: .white, backGroundColor: .systemPink)
    
    // MARK: - Variables
    weak var delegate: WishEventCreationViewDelegate?
    
    // MARK: - Lyfecycle
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        configureScreenTileLabel()
        configureCloseButton()
        configureEventStackView()
        configureCreateEventButton()
    }
    
    private func configureScreenTileLabel() {
        screenTitleLabel.text = Constants.screenTitleLabelText
        screenTitleLabel.textColor = .systemPink
        screenTitleLabel.numberOfLines = Constants.screenTitleLabelNumberOfLines
        screenTitleLabel.textAlignment = .center
        screenTitleLabel.font = Constants.screenTitleLabelFont
        screenTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(screenTitleLabel)
        screenTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.screenTitleLabelOffsetTop).isActive = true
        screenTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func configureCloseButton() {
        closeButton.setImage(Constants.closeButtonImage, for: .normal)
        closeButton.tintColor = .systemGray
        closeButton.addTarget(self, action: #selector(closeButtonWasTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant:
            Constants.closeButtonOffsetTop).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.closeButtonOffsetTrailing).isActive = true
    }
    
    private func configureEventStackView() {
        for textfield in [eventTitleTextField, eventDescriptionTextField, eventStartDateTextField, eventEndDateTextField] {
            textfield.translatesAutoresizingMaskIntoConstraints = false
        }
        
        eventStartDateTextField.setDelegate(self)
        eventEndDateTextField.setDelegate(self)
        
        eventStackView.addArrangedSubviews(eventTitleTextField, eventDescriptionTextField, eventStartDateTextField, eventEndDateTextField)
        
        eventStackView.axis = .vertical
        eventStackView.distribution = .fillEqually
        eventStackView.spacing = Constants.eventStackViewSpacing
        eventStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(eventStackView)
        eventStackView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Constants.eventStackViewOffsetTop).isActive = true
        eventStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.eventStackViewOffsetLeading).isActive = true
        eventStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.eventStackViewOffsetTrailing).isActive = true
    }
    
    private func configureCreateEventButton() {
        createEventButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(createEventButton)
        createEventButton.topAnchor.constraint(equalTo: eventStackView.bottomAnchor, constant: Constants.createEventButtonOffsetTop).isActive = true
        createEventButton.leadingAnchor.constraint(equalTo: eventStackView.leadingAnchor).isActive = true
        createEventButton.trailingAnchor.constraint(equalTo: eventStackView.trailingAnchor).isActive = true
    }
      
    // MARK: - Actions
    @objc private func closeButtonWasTapped() {
        self.delegate?.closeButtonWasTapped()
    }
}

// MARK: - UITextFieldDelegate
extension WishEventCreationView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.delegate?.textFieldDateWasTapped(currentTextField: textField)
        return false
    }
}
