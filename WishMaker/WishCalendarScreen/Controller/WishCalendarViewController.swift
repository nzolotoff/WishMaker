//
//  WishCalendarViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 19.01.2025.
//

import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Fields
    private let wishCalendarView: WishCalendarView = WishCalendarView()
    
    // MARK: - Lyfecycle
    override func loadView() {
        self.view = wishCalendarView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
