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
    func presentAlert(alert: UIAlertController)
    func deliverEvent(event: WishEventModel)
    func selectButtonWasTapped()
}

final class WishEventCreationView: UIView {
    // MARK: - Constants
    enum Constants {
        // screen title label
        static let screenTitleLabelText: String = "Create event here!"
        static let screenTitleLabelNumberOfLines: Int = 1
        static let screenTitleLabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .regular)
        static let screenTitleLabelOffsetTop: CGFloat = 26
        
        // close button
        static let closeButtonImage: UIImage? = UIImage(systemName: "xmark.circle")
        static let closeButtonOffsetTop: CGFloat = 24
        static let closeButtonOffsetTrailing: CGFloat = -1 * 20
        
        // select button
        static let selectButtonImageName: UIImage? = UIImage(systemName: "list.star")
        static let selectButtonOffsetTop: CGFloat = 72
        static let selectButtonOffsetLeading: CGFloat = 4
        static let selectButtonOffsetTrailing: CGFloat = -1 * 20

        // event stack view (textfields)
        static let eventStackViewSpacing: CGFloat = 24
        static let eventStackViewOffsetTop: CGFloat = 24
        
        // create event button
        static let createEventButtonOffsetTop: CGFloat = 24
        
        // event title textfield
        static let eventTitleTextFieldOffsetTop: CGFloat = 32
        static let eventTitleTextFieldOffsetLeading: CGFloat = 20
        static let eventTitleTextFieldOffsetTrailing: CGFloat = -1 * 68
        
        // alert
        static let alertTitle: String = "Ooops..."
        static let alertMessage: String = "Fill in all the fields"
        static let alertActionTitle: String = "OK"

        // date format
        static let dateFormat: String = "dd MMM yyyy, HH:mm"
    }
    
    // MARK: - Fields
    private let screenTitleLabel: UILabel = UILabel()
    private let closeButton: UIButton = UIButton(type: .system)
    private let selectButton: UIButton = UIButton(type: .system)
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
    
    // MARK: - Set text to title textfield
    func setTitleTextField(text: String) {
        eventTitleTextField.setText(text: text)
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        configureScreenTileLabel()
        configureCloseButton()
        configureEventTitleTextField()
        configureSelectButton()
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
        closeButton.tintColor = .systemBlue
        closeButton.addTarget(self, action: #selector(closeButtonWasTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.closeButtonOffsetTop).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.closeButtonOffsetTrailing).isActive = true
    }
    
    private func configureEventTitleTextField() {
        eventTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(eventTitleTextField)
        eventTitleTextField.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Constants.eventTitleTextFieldOffsetTop).isActive = true
        eventTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.eventTitleTextFieldOffsetLeading).isActive = true
        eventTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.closeButtonOffsetTrailing).isActive = true
    }
    
    private func configureSelectButton() {
        selectButton.setImage(Constants.selectButtonImageName, for: .normal)
        selectButton.tintColor = .systemPink
        selectButton.addTarget(self, action: #selector(selectButtonWasTapped), for: .touchUpInside)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(selectButton)
        
        selectButton.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Constants.selectButtonOffsetTop).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: eventTitleTextField.trailingAnchor, constant: Constants.selectButtonOffsetLeading).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.selectButtonOffsetTrailing).isActive = true
    }

    private func configureEventStackView() {
        for textfield in [eventDescriptionTextField, eventStartDateTextField, eventEndDateTextField] {
            textfield.translatesAutoresizingMaskIntoConstraints = false
        }
        
        eventStartDateTextField.setDelegate(self)
        eventEndDateTextField.setDelegate(self)
        
        eventStackView.addArrangedSubviews(
            eventDescriptionTextField,
            eventStartDateTextField,
            eventEndDateTextField
        )
        
        eventStackView.axis = .vertical
        eventStackView.distribution = .fillEqually
        eventStackView.spacing = Constants.eventStackViewSpacing
        eventStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(eventStackView)
        eventStackView.topAnchor.constraint(equalTo: eventTitleTextField.bottomAnchor, constant: Constants.eventStackViewOffsetTop).isActive = true
        eventStackView.leadingAnchor.constraint(equalTo: eventTitleTextField.leadingAnchor).isActive = true
        eventStackView.trailingAnchor.constraint(equalTo: selectButton.trailingAnchor).isActive = true
    }
    
    private func configureCreateEventButton() {
        createEventButton.translatesAutoresizingMaskIntoConstraints = false
        
        setActionForCreateEventButton()
        
        addSubview(createEventButton)
        createEventButton.topAnchor.constraint(equalTo: eventStackView.bottomAnchor, constant: Constants.createEventButtonOffsetTop).isActive = true
        createEventButton.leadingAnchor.constraint(equalTo: eventStackView.leadingAnchor).isActive = true
        createEventButton.trailingAnchor.constraint(equalTo: eventStackView.trailingAnchor).isActive = true
    }
    
    // MARK: - Actions
    @objc private func closeButtonWasTapped() {
        self.delegate?.closeButtonWasTapped()
    }
    
    @objc private func selectButtonWasTapped() {
        self.delegate?.selectButtonWasTapped()
    }
    
    private func setActionForCreateEventButton() {
        createEventButton.action = { [weak self] in
            guard let title = self?.eventTitleTextField.getText(), !title.isEmpty, let description = self?.eventDescriptionTextField.getText(), !description.isEmpty, let startDateString = self?.eventStartDateTextField.getText(), !startDateString.isEmpty, let endDateString = self?.eventEndDateTextField.getText(), !endDateString.isEmpty
            else {
                let alert = UIAlertController(
                    title: Constants.alertActionTitle,
                    message: Constants.alertMessage,
                    preferredStyle: .alert
                )
                let action = UIAlertAction(
                    title: Constants.alertActionTitle,
                    style: .default
                )
                alert.addAction(action)
                self?.delegate?.presentAlert(alert: alert)
                
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Constants.dateFormat
            
            let startDate = dateFormatter.date(from: startDateString)
            let endDate = dateFormatter.date(from: endDateString)
            
            self?.delegate?.deliverEvent(
                event: WishEventModel(
                    title: title,
                    description: description,
                    startDate: startDate ?? Date(),
                    endDate: endDate ?? Date()
                )
            )
        }
    }
}

// MARK: - UITextFieldDelegate
extension WishEventCreationView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.delegate?.textFieldDateWasTapped(currentTextField: textField)
        return false
    }
}
