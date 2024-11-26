//
//  WishStoringViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 21.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let wishesTableCorner: CGFloat = 20
        
        static let wishesTableTopOffset: CGFloat = 20
        static let wishesTableLeadingOffset: CGFloat = 10
        static let wishesTableTrailingOffset: CGFloat = -1 * 10
        static let wishesTableBottomOffset: CGFloat = -1 * 20
    }
    // MARK: - Fields
    private let wishesTable: UITableView = UITableView(frame: .zero)
    
    // MARK: - Varibles
    private var wishesArray: [String] = []
    private var sectionTitles: [String] = ["Add wish here", "My wishes"]
    private var wishService: WishServiceProtocol = WishService()

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = .cyan
        configureWishesTable()
    }
    
    private func configureWishesTable() {
        wishesTable.backgroundColor = .white
        wishesTable.separatorStyle = .singleLine
        wishesTable.dataSource = self
        wishesTable.delegate = self
        wishesTable.layer.cornerRadius = Constants.wishesTableCorner
        wishesTable.translatesAutoresizingMaskIntoConstraints = false
        wishesTable.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        wishesTable.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        view.addSubview(wishesTable)
        NSLayoutConstraint.activate([
            wishesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.wishesTableTopOffset),
            wishesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.wishesTableLeadingOffset),
            wishesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.wishesTableTrailingOffset),
            wishesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.wishesTableBottomOffset)
            ])
    }
}

// MARK: UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return wishService.getWishes().count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            guard let AddWishCell = cell as? AddWishCell else { return cell }
            
            AddWishCell.addWish = { [weak self] text in
                self?.wishService.addWish(text)
                self?.wishesTable.reloadData()
            }
            return AddWishCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            guard let wishCell = cell as? WrittenWishCell else { return cell }
           
            wishCell.configure(with: wishService.getWishes()[indexPath.row])
            return wishCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
}

extension WishStoringViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
