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
    private let wishEventCreationViewController: WishEventCreationViewController = WishEventCreationViewController()
    private let calendarManager: CalendarManaging

    // MARK: - Variables
    private var eventManager: EventCoreDataManagerLogic = EventCoreDataManager.shared
    
    // MARK: - Lyfecycle
    init(calendarManager: CalendarManaging = CalendarEventManager()) {
        self.calendarManager = calendarManager
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = wishCalendarView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wishCalendarView.delegate = self
        wishEventCreationViewController.delegate = self
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - WishCalendarViewDelegate
extension WishCalendarViewController: WishCalendarViewDelegate {
    func goBackButtonWasTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func addButtonWastapped() {
        let vc = WishEventCreationViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func getEvents() -> [WishEventModel]? {
        if case .success(let events) = eventManager.fetchEvents() {
            return events
        }
        return nil
    }
    
    func getEvent(byId id: Int) -> WishEventModel {
        let result = eventManager.fetchEvent(withID: id)
        switch result {
        case .success(let event): return event
        case .failure: return WishEventModel(
            title: "",
            description: "",
            startDate: Date(),
            endDate: Date()
        )
        }
    }
    
    func deleteEvent(byId id: Int) {
        eventManager.deleteEvent(withId: id)
    }
}

// MARK: - WishEventCreationViewControllerDelegate
extension WishCalendarViewController: WishEventCreationViewControllerDelegate {
    func createEvent(event: WishEventModel) {
        do {
            try eventManager.createEvent(event: event)
            wishCalendarView.reloadData()
            
            if !calendarManager.create(eventModel: event) {
                present(UIAlertController(title: "", message: "", preferredStyle: .alert), animated: true)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

