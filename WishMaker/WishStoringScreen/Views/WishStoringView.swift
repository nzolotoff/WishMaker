//
//  WishStoringView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.12.2024.
//

import UIKit

protocol WishStoringViewDelegate: AnyObject, WishServiceLogic {
    func presentAlert(alert: UIAlertController)
}

class WishStoringView: UIView {
    // MARK: - Constants
    enum Constants {
        static let wishesTableCorner: CGFloat = 20
        
        static let wishesTableTopOffset: CGFloat = 20
        static let wishesTableLeadingOffset: CGFloat = 10
        static let wishesTableTrailingOffset: CGFloat = -1 * 10
        static let wishesTableBottomOffset: CGFloat = -1 * 20
        
        static let numberOfSections: Int = 2
        static let numberOfRowsInFirstSection: Int = 1
        static let heightForRow: CGFloat = 50
        
        static let actionSheetCancelTitle: String = "Cancel"
        static let actionSheetEditTitle: String = "Edit"
        static let actionSheetDeleteTitle: String = "Delete"
        static let editAlertMessage: String = "Edit your wish below"
        static let editAlertCancelTitle: String = "Cancel"
        static let editAlertSaveTitle: String = "Save"
    }
    // MARK: - Fields
    private let wishesTable: UITableView = UITableView(frame: .zero)
    
    // MARK: - Varibles
    private var wishesArray: [String] = []
    private var sectionTitles: [String] = ["Add wish here", "My wishes"]
    weak var delegate: WishStoringViewDelegate?

    // MARK: - Lyfecycle
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        backgroundColor = .white
        configureWishesTable()
    }
    
    private func configureWishesTable() {
        wishesTable.backgroundColor = .clear
        wishesTable.separatorStyle = .none
        wishesTable.dataSource = self
        wishesTable.delegate = self
        wishesTable.layer.cornerRadius = Constants.wishesTableCorner
        wishesTable.translatesAutoresizingMaskIntoConstraints = false
        wishesTable.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        wishesTable.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        addSubview(wishesTable)
        NSLayoutConstraint.activate([
            wishesTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.wishesTableTopOffset),
            wishesTable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.wishesTableLeadingOffset),
            wishesTable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.wishesTableTrailingOffset),
            wishesTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Constants.wishesTableBottomOffset)
            ])
    }
}

// MARK: UITableViewDataSource
extension WishStoringView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return Constants.numberOfRowsInFirstSection
        case 1: return delegate?.getWishes().count ?? 0
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
                self?.delegate?.addWish(text)
                self?.wishesTable.reloadData()
            }
            return AddWishCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            guard let wishCell = cell as? WrittenWishCell else { return cell }
           
            wishCell.configure(with: delegate?.getWishes()[indexPath.row] ?? "")
            return wishCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
}

// MARK: UITableViewDelegate
extension WishStoringView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        switch indexPath.section {
        case 1: return .delete
        default: return .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.deleteWish(at: indexPath.row)
            wishesTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let wishToEdit = delegate?.getWishes()[indexPath.row]
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: Constants.actionSheetCancelTitle, style: .cancel))
            actionSheet.addAction(UIAlertAction(title: Constants.actionSheetEditTitle, style: .default, handler: { [weak self] _ in
                let editAlert = UIAlertController(title: wishToEdit, message: Constants.editAlertMessage, preferredStyle: .alert)
                self?.delegate?.presentAlert(alert: editAlert)
                editAlert.addAction(UIAlertAction(title: Constants.editAlertCancelTitle, style: .destructive))
                editAlert.addTextField { textField in
                    textField.text = wishToEdit
                }
                editAlert.addAction(UIAlertAction(title: Constants.editAlertSaveTitle, style: .default, handler: { [weak self] _ in
                    if let newWish = editAlert.textFields?.first?.text, !newWish.isEmpty {
                        self?.delegate?.editWish(at: indexPath.row, to: newWish)
                        self?.wishesTable.reloadData()
                    }
                }))
            }))
            actionSheet.addAction(UIAlertAction(title: Constants.actionSheetDeleteTitle, style: .destructive, handler: { [weak self] _ in
                self?.delegate?.deleteWish(at: indexPath.row)
                self?.wishesTable.reloadData()
            }))
            delegate?.presentAlert(alert: actionSheet)
        }
    }
}
