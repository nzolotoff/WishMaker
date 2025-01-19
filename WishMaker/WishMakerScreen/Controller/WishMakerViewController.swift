//
//  ViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.11.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    // MARK: - Fields
    private let wishMakerView: WishMakerView = WishMakerView()
    
    // MARK: - Lyfecycle
    override func loadView() {
        self.view = wishMakerView
        wishMakerView.delegate = self
    }
}

extension WishMakerViewController: WishMakerViewDelegate {
    func addWishWasPressed() {
        present(WishStoringViewController(), animated: true)
    }
}
