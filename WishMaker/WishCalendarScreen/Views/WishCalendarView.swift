//
//  WishStoringView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 22.01.2025.
//

import UIKit

//protocol WishCalendarViewDelegate {
//    
//}

final class WishCalendarView: UIView {
    // MARK: - Constants
    enum Constants {
        
        // collection
        static let collectionInset: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        static let collectionTopOffset: CGFloat = 12
        static let collectionNumberOfItemsInSection: Int = 10
        static let collectionCellSize: CGSize = CGSize(width: 44, height: 44)
        static let nameOfCellReuseIdentifier: String = "cell"
    }
    
    // MARK: - Fields
    private let myCollection: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Variables

    
    // MARK: Lyfecycle
    init () {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = .cyan
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        myCollection.dataSource = self
        myCollection.delegate = self
        myCollection.backgroundColor = .white
        myCollection.alwaysBounceVertical = true
        myCollection.showsVerticalScrollIndicator = false
        myCollection.contentInset = Constants.collectionInset
        
        // temporary
        myCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.nameOfCellReuseIdentifier)
        
        self.addSubview(myCollection)
        
        myCollection.translatesAutoresizingMaskIntoConstraints = false
        myCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.collectionTopOffset).isActive = true
        myCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    

}

extension WishCalendarView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return Constants.collectionNumberOfItemsInSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.nameOfCellReuseIdentifier, for: indexPath)
        return cell
    }
}

extension WishCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return Constants.collectionCellSize
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("cell tapped at index \(indexPath.item)")
    }
}
