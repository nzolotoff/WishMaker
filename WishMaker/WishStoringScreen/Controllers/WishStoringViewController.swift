//
//  WishStoringViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 21.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Fields
    private let wishStoringView: WishStoringView = WishStoringView()
    private var wishService: WishServiceLogic
    
    // MARK: - Lyfecycle
    init(wishService: WishServiceLogic = WishService()) {
        self.wishService = wishService
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = wishStoringView
        wishStoringView.delegate = self
    }
}

// MARK: - WishStoringViewDelegate
extension WishStoringViewController: WishStoringViewDelegate {
    func getWishes() -> [String] {
        wishService.getWishes()
    }
    
    func addWish(_ wish: String) {
        wishService.addWish(wish)
    }
    
    func editWish(at index: Int, to newWish: String) {
        wishService.editWish(at: index, to: newWish)
    }
    
    func deleteWish(at index: Int) {
        wishService.deleteWish(at: index)
    }
    
    func presentAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}
