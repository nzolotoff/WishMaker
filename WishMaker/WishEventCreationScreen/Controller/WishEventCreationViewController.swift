//
//  WishEventCreationViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 28.01.2025.
//

import UIKit

protocol WishEventCreationViewControllerDelegate: AnyObject {
    func createEvent(event: WishEventModel)
}

final class WishEventCreationViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let eventSetupDatePopoverHeight: CGFloat = 480
        
        // select wishes popover size
        static let selectWishesViewControllerSize: CGSize = CGSize(width: 370, height: 380)
        static let popoverSouceRect: CGRect = CGRect(
            origin: CGPoint(
                x: 201,
                y: 170
            ),
            size: CGSize(
                width: 1,
                height: 1
            )
        )
    }
    
    // MARK: - Fields
    private let myView: WishEventCreationView = WishEventCreationView()
    private let eventSetupDateViewController: EventSetupDateViewController
    private let selectWishesViewController: SelectWishesViewController
    
    // MARK: - Variables
    private var currentTextField: UITextField?
    weak var delegate: WishEventCreationViewControllerDelegate?

    // MARK: - Lyfecycle
    init(
        eventSetupDateViewController: EventSetupDateViewController = EventSetupDateViewController(),
        selectWishesViewController: SelectWishesViewController = SelectWishesViewController()
    ) {
        self.eventSetupDateViewController = eventSetupDateViewController
        self.selectWishesViewController = selectWishesViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.delegate = self
        eventSetupDateViewController.delegate = self
        selectWishesViewController.delegate = self
    }
}

// MARK: - WishEventCreationViewDelegate
extension WishEventCreationViewController: WishEventCreationViewDelegate {
    func selectButtonWasTapped() {
        selectWishesViewController.modalPresentationStyle = .popover
        selectWishesViewController.preferredContentSize = Constants.selectWishesViewControllerSize

        if #available(iOS 15.0, *) {
            if let popover = selectWishesViewController.popoverPresentationController {
                popover.sourceView = self.myView
                popover.sourceRect = Constants.popoverSouceRect
                popover.permittedArrowDirections = .up
                popover.delegate = self
            }
        }
        present(selectWishesViewController, animated: true)
    }
    
    func presentAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func textFieldDateWasTapped(currentTextField: UITextField) {
        self.currentTextField = currentTextField
        
        eventSetupDateViewController.modalPresentationStyle = .pageSheet
        
        if #available(iOS 16.0, *) {
            if let sheet = eventSetupDateViewController.sheetPresentationController {
                sheet.detents = [.custom(resolver: { context in
                    return Constants.eventSetupDatePopoverHeight
                })]
            }
        }
        
        present(eventSetupDateViewController, animated: true)
    }
    
    func deliverEvent(event: WishEventModel) {
        self.delegate?.createEvent(event: event)
        dismiss(animated: true)
    }
    
    func closeButtonWasTapped() {
        dismiss(animated: true)
    }
}

// MARK: - EventSetupDateViewControllerDelegate
extension WishEventCreationViewController: EventSetupDateViewControllerDelegate {
    func setDateToTextField(date: String) {
        self.currentTextField?.text = date
    }
}

// MARK: - SelectWishesViewControllerDelegate
extension WishEventCreationViewController: SelectWishesViewControllerDelegate {
    func setToTitle(wish: String) {
        myView.setTitleTextField(text: wish)
    }
}

extension WishEventCreationViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController
    ) -> UIModalPresentationStyle {
        return .none
    }
}
