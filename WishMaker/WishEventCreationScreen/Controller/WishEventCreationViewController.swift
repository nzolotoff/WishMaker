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
    }
    
    // MARK: - Fields
    private let myView: WishEventCreationView = WishEventCreationView()
    private let eventSetupDateViewController: EventSetupDateViewController = EventSetupDateViewController()
    
    // MARK: - Variables
    private var currentTextField: UITextField?
    weak var delegate: WishEventCreationViewControllerDelegate?

    override func loadView() {
        self.view = myView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.delegate = self
        eventSetupDateViewController.delegate = self
    }
}

// MARK: - WishEventCreationViewDelegate
extension WishEventCreationViewController: WishEventCreationViewDelegate {
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
    func setDateToTextField(startDate: String) {
        self.currentTextField?.text = startDate
    }
}
