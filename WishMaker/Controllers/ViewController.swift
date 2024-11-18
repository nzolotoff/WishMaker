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
        
        static let descriptionLines: Int = 0
        static let descriptionLabelSize: CGFloat = 12
        static let descriptionLabelTop: CGFloat = 20
        static let descriptionLabelLeading: CGFloat = 20
        
        static let sliderStackCorner: CGFloat = 20
        static let sliderStackBottom: CGFloat = -40
        static let sliderStackLeading: CGFloat = 20
        
        static let alphaRGB: CGFloat = 1
    }
    
    // MARK: - Variables
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let sliderStack = UIStackView()
    private let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    private let buttonStack = UIStackView()
    private let hideButton = CustomButton(title: "Hide sliders")
    private let randomButton = CustomButton(title: "Randomize background color")
    
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
    }
    
    private func configureTitle() {
        titleLabel.text = "WishMaker"
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
        descriptionLabel.text = "This app will bring you joy and will fulfill three of your wishes! The first wish is change the background color."
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
        }
        
        NSLayoutConstraint.activate([
            sliderStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sliderStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sliderStackLeading),
            sliderStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.sliderStackBottom)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self?.updateBackground()
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.updateBackground()
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.updateBackground()
        }
    }
    
    private func updateBackground() {
        let red = sliderRed.slider.value
        let green = sliderGreen.slider.value
        let blue = sliderBlue.slider.value
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: Constants.alphaRGB)
        
    }
    
    private func configureButtonStack() {
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        for button in [hideButton, randomButton] {
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonStack.addArrangedSubview(button)
        }
        
        view.addSubview(buttonStack)
        NSLayoutConstraint.activate([
            buttonStack.bottomAnchor.constraint(equalTo: sliderStack.topAnchor, constant: -20),
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}

