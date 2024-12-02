//
//  WishMakerView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 02.12.2024.
//

import UIKit

protocol WishMakerViewDelegate: AnyObject {
    func addWishWasPressed()
}

class WishMakerView: UIView {
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
        static let sliderStackBottom: CGFloat = -340
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
        
        // add wish button
        static let addWishButtonTitle: String = "My wishes"
        static let addWishButtonCorner: CGFloat = 20
        static let addWishButtonTopIdent: CGFloat = 20
        static let addWishButtonHeight: CGFloat = 52
    }
    
    // MARK: - Fields
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    private let hideButton: ColorButton = ColorButton(title: Constants.hideButtonTitleHide)
    private let randomButton: ColorButton = ColorButton(title: Constants.randomButtomTitle)
    private let buttonStack: UIStackView = UIStackView()
    
    private let sliderRed: CustomSlider = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen: CustomSlider = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue: CustomSlider = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderStack: UIStackView = UIStackView()

    private let addWishButton: UIButton = UIButton(type: .system)
    
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
        backgroundColor = .cyan
        configureTitle()
        configureDescription()
        configureSlidersStack()
        configureColorButtonsStack()
        configureAddWishButton()
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
        buttonStack.axis = .horizontal
        buttonStack.spacing = Constants.buttonStackSpacing
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        setActionForHideButton()
        setActionForRandomButton()
        for button in [hideButton, randomButton] {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeighInStack).isActive = true
            buttonStack.addArrangedSubview(button)
        }
        
        addSubview(buttonStack)
        NSLayoutConstraint.activate([
            buttonStack.bottomAnchor.constraint(equalTo: sliderStack.topAnchor, constant: Constants.buttonStackBottom),
            buttonStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.buttonStackLeading)
        ])
    }
    
    private func configureSlidersStack() {
        sliderStack.axis = .vertical
        sliderStack.layer.cornerRadius = Constants.sliderStackCorner
        sliderStack.clipsToBounds = true
        sliderStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sliderStack)
        for view in [sliderRed, sliderGreen, sliderBlue] {
            sliderStack.addArrangedSubview(view)
            view.valueChanged = { [weak self] _ in
                self?.updateBackgroundColor()
            }
        }
        
        NSLayoutConstraint.activate([
            sliderStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            sliderStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderStackLeading),
            sliderStack.topAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderStackBottom)
        ])
    }
    
    private func configureAddWishButton() {
        addWishButton.setTitle(Constants.addWishButtonTitle, for: .normal)
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.backgroundColor = .white
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.layer.cornerRadius = Constants.addWishButtonCorner
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
        
        addSubview(addWishButton)
        NSLayoutConstraint.activate([
            addWishButton.heightAnchor.constraint(equalToConstant: Constants.addWishButtonHeight),
            addWishButton.topAnchor.constraint(equalTo: sliderStack.bottomAnchor, constant: Constants.addWishButtonTopIdent),
            addWishButton.leadingAnchor.constraint(equalTo: sliderStack.leadingAnchor),
            addWishButton.trailingAnchor.constraint(equalTo: sliderStack.trailingAnchor),
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
    
    @objc private func addWishButtonTapped() {
        delegate?.addWishWasPressed()
    }
}
