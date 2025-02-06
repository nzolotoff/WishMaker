//
//  WishMakerView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 02.12.2024.
//

import UIKit

protocol WishMakerViewDelegate: AnyObject {
    func addWishWasPressed()
    func scheduleWishesWasPressed()
}

final class WishMakerView: UIView {
    enum Constants {
        
        // min/max values for sliders
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        // colors
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let alphaRGB: CGFloat = 1
        
        // title label
        static let titleLabelSize: CGFloat = 32
        static let titleLabelLeading: CGFloat = 20
        static let titleLabelTop: CGFloat = 30
        static let titleLabelText: String = "Wish Maker"
        
        // description label
        static let descriptionLines: Int = 0
        static let descriptionLabelSize: CGFloat = 12
        static let descriptionLabelTop: CGFloat = 20
        static let descriptionLabelLeading: CGFloat = 20
        static let descriptionLabelText: String = "This app will bring you joy and will fulfill three of your wishes! The first wish is change the background color."
        
        // sliders stack
        static let sliderStackCorner: CGFloat = 20
        static let sliderStackBottomOffset: CGFloat = -420
        static let sliderStackLeading: CGFloat = 20
        
        // color buttons stack
        static let buttonStackSpacing: CGFloat = 10
        static let buttonStackLeading: CGFloat = 20
        static let buttonStackBottom: CGFloat = -20
        static let buttonHeighInStack: CGFloat = 38
        
        // hide button
        static let hideButtonTitleHide: String = "Hide sliders"
        static let hideButtonTitleShow: String = "Show sliders"
        
        // random button
        static let randomButtomTitle: String = "Random color"
        
        // wish button stack
        static let wishButtonStackSpacing: CGFloat = 12
        static let wishButtonStackTopIdent: CGFloat = 20
        
        // add wish button
        static let addWishButtonTitle: String = "My wishes"
        static let addWishButtonTopIdent: CGFloat = 20
        
        // schedule wishes button
        static let scheduleWishesButton: String = "Schedule wish granting"
    }
    
    // MARK: - Fields
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    private let hideButton: ColorButton = ColorButton(title: Constants.hideButtonTitleHide)
    private let randomButton: ColorButton = ColorButton(title: Constants.randomButtomTitle)
    private let colorButtonsStack: UIStackView = UIStackView()
    
    private let sliderRed: CustomSlider = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen: CustomSlider = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue: CustomSlider = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderStack: UIStackView = UIStackView()

    private let addWishButton: WishButton = WishButton(title: Constants.addWishButtonTitle)
    private let scheduleWishesButton: WishButton = WishButton(title: Constants.scheduleWishesButton)
    private let wishButtonsStack: UIStackView = UIStackView()
    
    // MARK: - Variables
    override var backgroundColor: UIColor? {
        didSet {
            let buttons: [TitleColorSettable] = [hideButton, randomButton, addWishButton, scheduleWishesButton]
            for button in buttons  {
                button.button.setTitleColor(backgroundColor, for: .normal)
            }
        }
    }
    
    weak var delegate: WishMakerViewDelegate?
    
    // MARK: - Lyfecycle
    init () {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        backgroundColor = .systemPink
        configureTitle()
        configureDescription()
        configureSlidersStack()
        configureColorButtonsStack()
        configureWishButtonsStack()
    }
    
    private func configureTitle() {
        titleLabel.text = Constants.titleLabelText
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleLabelSize, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelLeading),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.titleLabelTop)
        ])
    }
    
    private func configureDescription() {
        descriptionLabel.text = Constants.descriptionLabelText
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionLabelSize)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = Constants.descriptionLines
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionLabelTop),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.descriptionLabelLeading)
        ])
    }
    
    private func configureColorButtonsStack() {
        colorButtonsStack.axis = .horizontal
        colorButtonsStack.spacing = Constants.buttonStackSpacing
        colorButtonsStack.distribution = .fillEqually
        colorButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        setActionForHideButton()
        setActionForRandomButton()
        colorButtonsStack.addArrangedSubviews(hideButton, randomButton)
        
        addSubview(colorButtonsStack)
        NSLayoutConstraint.activate([
            colorButtonsStack.bottomAnchor.constraint(equalTo: sliderStack.topAnchor, constant: Constants.buttonStackBottom),
            colorButtonsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorButtonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.buttonStackLeading)
        ])
    }
    
    private func configureSlidersStack() {
        sliderStack.axis = .vertical
        sliderStack.layer.cornerRadius = Constants.sliderStackCorner
        sliderStack.clipsToBounds = true
        sliderStack.translatesAutoresizingMaskIntoConstraints = false
        
        sliderStack.addArrangedSubviews(sliderRed, sliderGreen, sliderBlue)
        for view in [sliderRed, sliderGreen, sliderBlue] {
            view.valueChanged = { [weak self] _ in
                self?.updateBackgroundColor()
            }
        }
        
        addSubview(sliderStack)
        NSLayoutConstraint.activate([
            sliderStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            sliderStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderStackLeading),
            sliderStack.topAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderStackBottomOffset)
        ])
    }
    
    private func configureWishButtonsStack() {
        wishButtonsStack.axis = .vertical
        wishButtonsStack.spacing = Constants.wishButtonStackSpacing
        wishButtonsStack.distribution = .fillEqually
        
        setActionForAddWishButton()
        setActionForScheduleWishesButton()
        wishButtonsStack.addArrangedSubviews(addWishButton, scheduleWishesButton)
        
        addSubview(wishButtonsStack)
        wishButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wishButtonsStack.topAnchor.constraint(equalTo: sliderStack.bottomAnchor, constant: Constants.wishButtonStackTopIdent),
            wishButtonsStack.leadingAnchor.constraint(equalTo: sliderStack.leadingAnchor),
            wishButtonsStack.trailingAnchor.constraint(equalTo: sliderStack.trailingAnchor),
        ])
    }
    
    // MARK: - Actions
    private func setActionForHideButton() {
        hideButton.action = { [weak self] in
            guard let self else { return }
            if self.sliderStack.isHidden {
                self.hideButton.button.setTitle(Constants.hideButtonTitleHide, for: .normal)
                self.sliderStack.isHidden = false
            } else {
                self.hideButton.button.setTitle(Constants.hideButtonTitleShow, for: .normal)
                self.sliderStack.isHidden = true
            }
        }
    }
    
    private func setActionForRandomButton() {
        randomButton.action = { [weak self] in
            self?.backgroundColor = UIColor.randomColor()
        }
    }
    
    private func updateBackgroundColor() {
        let red = sliderRed.slider.value
        let green = sliderGreen.slider.value
        let blue = sliderBlue.slider.value
        backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: Constants.alphaRGB)
    }
    
    private func setActionForAddWishButton() {
        addWishButton.action = { [weak self] in
            self?.delegate?.addWishWasPressed()
        }
    }
    
    private func setActionForScheduleWishesButton() {
        scheduleWishesButton.action = { [weak self] in
            self?.delegate?.scheduleWishesWasPressed()
        }
    }
}
