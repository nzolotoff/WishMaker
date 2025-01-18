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
    private var wishManager = WishCoreDataManager.shared
    
    // MARK: - Lyfecycle
    override func loadView() {
        self.view = wishStoringView
        wishStoringView.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - WishStoringViewDelegate
extension WishStoringViewController: WishStoringViewDelegate {
    func shareWishes() {
        if case .success(let wishes) = wishManager.fetchWishes() {
            let wishesArray = wishes.map(\.title)
            let wishesTitlesToShare = wishesArray.compactMap { $0 }
            print(wishesTitlesToShare)
            let activityController = UIActivityViewController(activityItems: ["\(wishesTitlesToShare)"], applicationActivities: nil)
            present(activityController, animated: true)
        }
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
    
    func presentAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func addWish(id: Int, _ wish: String) {
        do {
            try wishManager.createWish(withId: Int16(id), title: wish)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            presentAlert(alert: alert)
        }
    }
    
    func getWishes() -> [String] {
        let wishes = wishManager.fetchWishes()
        var wishTitles = [String]()
        if case .success(let wishes) = wishes {
            wishes.forEach { wish in
                wishTitles.append(wish.title ?? "")
            }
            return wishTitles
        }
        return []
    }
    
    func editWish(at index: Int, to newWish: String) {
        wishManager.updateWish(withId: Int16(index), to: newWish)
    }
    
    func deleteWish(at index: Int) {
        wishManager.deleteWish(withId: Int16(index))
    }
}
