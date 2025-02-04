//
//  EventSetupDateViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 29.01.2025.
//

import UIKit

protocol EventSetupDateViewControllerDelegate: AnyObject {
    func setDateToTextField(startDate: String)
}

final class EventSetupDateViewController: UIViewController {
    // MARK: - Fields
    private let myView: EventSetupDateView = EventSetupDateView()
    
    // MARK: - Variables
    weak var delegate: EventSetupDateViewControllerDelegate?
    
    // MARK: - Lyfecycle
    override func loadView() {
        self.view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myView.delegate = self
    }
}

// MARK: - EventSetupDateViewDelegate
extension EventSetupDateViewController: EventSetupDateViewDelegate {
    func cancelButtonWasTapped() {
        dismiss(animated: true)
    }
    
    func doneButtonWasTapped(currentDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        let stringDate = dateFormatter.string(from: currentDate)
        
        delegate?.setDateToTextField(startDate: stringDate)
        dismiss(animated: true)
    }
}
