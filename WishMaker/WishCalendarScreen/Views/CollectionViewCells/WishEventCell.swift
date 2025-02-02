//
//  WishEventCell.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 23.01.2025.
//

import UIKit

class WishEventCell: UICollectionViewCell {
    // MARK: - Constants
    enum Constants {
        // wrap view
        static let wrapViewCorner: CGFloat = 12
        
        // title label
        static let titleLabelFontSize: CGFloat = 18
        static let titleLabelNumberOfLines: Int = 1
        static let titleLabelOffsetTop: CGFloat = 8
        static let titleLabelOffsetLeading: CGFloat = 12
        static let titleLabelOffsetTrailing: CGFloat = -1 * 12
        static let titleLabelHeight: CGFloat = 18
        
        // description label
        static let descriptionLabelFontSizeWeight: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let descriptionLabelNumberOfLines: Int = 1
        static let descriptionLabelOffsetTop: CGFloat = 8
        static let descriptionLabelOffsetLeading: CGFloat = 12
        static let descriptionLabelOffsetTrailing: CGFloat = -1 * 12
        static let descriptionHeight: CGFloat = 17
        
        // stack labels
        static let stackLabelsNumberOfLines: Int = 1
        static let stackLabelsFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        // date stack
        static let dateStackOffsetTop: CGFloat = 8
        static let dateStackOffsetTrailing: CGFloat = -1 * 12
        static let dateStackOffsetLeading: CGFloat = 12
        static let dateStackOffsetBottom: CGFloat = -1 * 8
    }
    
    // MARK: - Fields
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    private let dateStackView: UIStackView = UIStackView()
    
    // MARK: - Lyfecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configureCell(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = event.startDate.lowercased()
        endDateLabel.text = event.endDate.lowercased()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        self.backgroundColor = .clear
        
        configureWrapView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureDateStackView()
    }
    
    private func configureWrapView() {
        wrapView.backgroundColor = .systemPink
        wrapView.layer.cornerRadius = Constants.wrapViewCorner
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(wrapView)
        wrapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wrapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        wrapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        wrapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func configureTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleLabelFontSize)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        wrapView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: Constants.titleLabelOffsetTop).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.titleLabelOffsetLeading).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: Constants.titleLabelOffsetTrailing).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight).isActive = true
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.textColor = .white
        descriptionLabel.font = Constants.descriptionLabelFontSizeWeight
        descriptionLabel.numberOfLines = Constants.descriptionLabelNumberOfLines
        descriptionLabel.textAlignment = .left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionLabelOffsetTop).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.descriptionLabelOffsetLeading).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: Constants.descriptionLabelOffsetTrailing).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: Constants.descriptionHeight).isActive = true
    }
    
    private func configureDateStackView() {
        // configure labels
        for label in [startDateLabel, endDateLabel] {
            label.numberOfLines = Constants.stackLabelsNumberOfLines
            label.textColor = .white
            label.font = Constants.stackLabelsFont
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        startDateLabel.textAlignment = .left
        endDateLabel.textAlignment = .right

        // configure stack
        dateStackView.axis = .horizontal
        dateStackView.distribution = .equalSpacing
        dateStackView.addArrangedSubviews(startDateLabel, endDateLabel)
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        wrapView.addSubview(dateStackView)
        dateStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.dateStackOffsetTop).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.dateStackOffsetLeading).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: Constants.dateStackOffsetTrailing).isActive = true
        dateStackView.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: Constants.dateStackOffsetBottom).isActive = true
    }
}
