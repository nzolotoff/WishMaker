//
//  SelectWishesViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 06.02.2025.
//

import Foundation
import UIKit

protocol SelectWishesViewControllerDelegate: AnyObject {
    func setToTitle(wish: String)
}

final class SelectWishesViewController: UIViewController {
    // MARK: - Fields
    private let myView: SelectWishesView = SelectWishesView()
    
    // MARK: - Variables
    weak var delegate: SelectWishesViewControllerDelegate?
    
    // MARK: - Lyfecycle
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    
    override func viewDidLoad() {
        myView.delegate = self
    }
}

extension SelectWishesViewController: SelectWishesViewDelegate {
    func cancelButtonWasTapped() {
        dismiss(animated: true)
    }
    
    func doneButtonWasTapped(wish: String) {
        self.delegate?.setToTitle(wish: wish)
        dismiss(animated: true)
    }
    
    func getWishes() -> [String] {
        let wishes = WishCoreDataManager.shared.fetchWishes()
        var wishTitles = [String]()
        if case .success(let wishes) = wishes {
            wishes.forEach { wish in
                wishTitles.append(wish.title ?? "")
            }
            return wishTitles
        }
        return []
    }
}
