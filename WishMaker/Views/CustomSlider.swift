//
//  CustomSlider.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.11.2024.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Constants
    enum Constants {
        static let titleLabelLeadingIdent: CGFloat = 20
        static let titleLabelTopIdent: CGFloat = 10
        
        static let sliderBottomIdent: CGFloat = -10
        static let sliderLeadingIdent: CGFloat = 20
    }
    // MARK: - Properties
    var valueChanged: ((Double) -> Void)?
    
    // MARK: - Variables
    var slider = UISlider()
    var titleLabel = UILabel()
    
    // MARK: - Lyfecycle
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleLabel.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
    
    // MARK: - Private methods
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleLabel] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelLeadingIdent),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTopIdent),
            
            slider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottomIdent),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeadingIdent)
        ])
    }
}
