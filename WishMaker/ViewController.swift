//
//  ViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.11.2024.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Variables
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

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
    }
    
    private func configureTitle() {
        titleLabel.text = "WishMaker"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    private func configureDescription() {
        descriptionLabel.text = "This app will bring you joy and will fulfill three of your wishes! The first wish is change the background color."
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}

