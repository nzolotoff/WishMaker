//
//  ViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.11.2024.
//

import UIKit

final class ViewController: UIViewController {
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        
        static let titleLabelSize: CGFloat = 32
        static let titleLabelLeading: CGFloat = 20
        static let titleLabelTop: CGFloat = 30
        static let titleLabelText: String = "Wish Maker"

        
        static let descriptionLines: Int = 0
        static let descriptionLabelSize: CGFloat = 12
        static let descriptionLabelTop: CGFloat = 20
        static let descriptionLabelLeading: CGFloat = 20
        static let descriptionLabelText: String = "This app will bring you joy and will fulfill three of your wishes! The first wish is change the background color."
        
        static let sliderStackCorner: CGFloat = 20
        static let sliderStackBottom: CGFloat = -40
        static let sliderStackLeading: CGFloat = 20
        
        static let alphaRGB: CGFloat = 1
        
        static let buttonStackSpacing: CGFloat = 10
        static let buttonStackLeading: CGFloat = 20
        static let buttonStackBottom: CGFloat = -20
        
        static let hideButtonTitleHide: String = "Hide sliders"
        static let hideButtonTitleShow: String = "Show sliders"
        static let randomButtomTitle: String = "Random color"
    }
    
    // MARK: - Fields
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let sliderStack = UIStackView()
    private let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    private let buttonStack = UIStackView()
    private let hideButton = CustomButton(title: Constants.hideButtonTitleHide)
    private let randomButton = CustomButton(title: Constants.randomButtomTitle)
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = .cyan
        
        configureTitle()
        configureDescription()
        configureSliders()
        configureButtonStack()
        configureHideButton()
        configureRandomButton()
    }
    
    private func configureTitle() {
        titleLabel.text = Constants.titleLabelText
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleLabelSize, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLabelLeading),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleLabelTop)
        ])
    }
    
    private func configureDescription() {
        descriptionLabel.text = Constants.descriptionLabelText
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionLabelSize)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = Constants.descriptionLines
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionLabelTop),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionLabelLeading)
        ])
    }
    
    private func configureSliders() {
        sliderStack.axis = .vertical
        sliderStack.layer.cornerRadius = Constants.sliderStackCorner
        sliderStack.clipsToBounds = true
        sliderStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(sliderStack)
        for view in [sliderRed, sliderGreen, sliderBlue] {
            sliderStack.addArrangedSubview(view)
            view.valueChanged = { [weak self] _ in
                self?.updateBackground()
            }
        }
        
        NSLayoutConstraint.activate([
            sliderStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sliderStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sliderStackLeading),
            sliderStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.sliderStackBottom)
        ])
    }
    
    private func updateBackground() {
        let red = sliderRed.slider.value
        let green = sliderGreen.slider.value
        let blue = sliderBlue.slider.value
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: Constants.alphaRGB)
    }
    
    private func configureButtonStack() {
        buttonStack.axis = .horizontal
        buttonStack.spacing = Constants.buttonStackSpacing
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        for button in [hideButton, randomButton] {
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonStack.addArrangedSubview(button)
        }
        
        view.addSubview(buttonStack)
        NSLayoutConstraint.activate([
            buttonStack.bottomAnchor.constraint(equalTo: sliderStack.topAnchor, constant: Constants.buttonStackBottom),
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonStackLeading)
        ])
    }
    
    private func configureHideButton() {
        hideButton.addTarget(self, action: #selector (hideButtonTapped), for: .touchUpInside)
    }
    
    private func configureRandomButton() {
        randomButton.addTarget(self, action: #selector (randomButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func hideButtonTapped() {
        if sliderStack.isHidden {
            hideButton.setTitle(Constants.hideButtonTitleHide, for: .normal)
            sliderStack.isHidden = false
        } else {
            hideButton.setTitle(Constants.hideButtonTitleShow, for: .normal)
            sliderStack.isHidden = true
        }
    }
    
    @objc private func randomButtonTapped() {
        view.backgroundColor = UIColor.randomColor()
    }
}
