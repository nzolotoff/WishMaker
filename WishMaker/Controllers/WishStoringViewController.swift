//
//  WishStoringViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 21.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Fields
    private let wishesTable: UITableView = UITableView(frame: .zero)
    
    // MARK: - Varibles
    private var wishesArray: [String] = ["My first wish", "My first wish", "My first wish", "My first wish", "My first wish", "My first wish"]

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
        wishesTable.separatorStyle = .none
        wishesTable.dataSource = self
        wishesTable.layer.cornerRadius = 20
        wishesTable.translatesAutoresizingMaskIntoConstraints = false
        wishesTable.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        wishesTable.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        view.addSubview(wishesTable)
        NSLayoutConstraint.activate([
            wishesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            wishesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wishesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wishesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
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
        case 1: return wishesArray.count
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
                self?.wishesArray.append(text)
                self?.wishesTable.reloadData()
            }
            return AddWishCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            guard let wishCell = cell as? WrittenWishCell else { return cell }
           
            wishCell.configure(with: wishesArray[indexPath.row])
            return wishCell
        default:
            return UITableViewCell()
        }
    }
}
