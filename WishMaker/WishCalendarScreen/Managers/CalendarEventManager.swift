//
//  CalendarManager.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 06.02.2025.
//

import Foundation
import EventKit

enum Constants {
    static let errorMessage: String = "failed to create event with error: "
}

protocol CalendarManaging {
    func create(eventModel: WishEventModel) -> Bool
}

final class CalendarEventManager: CalendarManaging {
    // MARK: - Fields
    let eventStore: EKEventStore = EKEventStore()
    
    // MARK: - Create event methods
    func create(eventModel: WishEventModel) -> Bool {
        var result: Bool = false
        let group = DispatchGroup()
        
        group.enter()
        
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        
        group.wait()
    
        return result
    }
    
    func create(eventModel: WishEventModel, completion: ((Bool) -> Void)?) {
        let createEvent: EKEventStoreRequestAccessCompletionHandler = { [weak self] (
            granted,
            error
        ) in
            guard granted, error == nil, let self else {
                completion?(false)
                return
            }
            
            let event: EKEvent = EKEvent(eventStore: self.eventStore)
            
            event.title = eventModel.title
            event.notes = eventModel.description
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            
            do {
                try self.eventStore.save(event, span: .thisEvent)
            } catch let error as NSError {
                print(Constants.errorMessage, error)
                completion?(false)
            }
            
            completion?(true)
        }
        
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents(completion: createEvent)
        } else {
            eventStore.requestAccess(to: .event, completion: createEvent)
        }
    }
}


