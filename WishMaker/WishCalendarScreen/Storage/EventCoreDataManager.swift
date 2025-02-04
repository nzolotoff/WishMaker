//
//  EventCoreDataManager.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.02.2025.
//

import Foundation
import UIKit
import CoreData

protocol EventCoreDataManagerLogic {
    func createEvent(event: WishEventModel) throws
    func fetchEvents() -> Result<[WishEventModel], EventManagerError>
    func fetchEvent(withID id: Int) -> Result<WishEventModel, EventManagerError>
    func deleteEvent(withId id: Int)
}

// MARK: - Types of errors
public enum EventManagerError: Error {
    case entityNotFound
    case listOfEventsNotFound
    case eventNotFound
}

final class EventCoreDataManager: EventCoreDataManagerLogic {
    // MARK: - Constants
    enum Constants {
        static let entityName: String = "Event"
    }
    // MARK: - Singleton
    static let shared: EventCoreDataManager = EventCoreDataManager()
    private init() { }
    
    // MARK: - Variables
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistenceContainer.viewContext
    }
    
    // MARK: - CRUD Methods
    func createEvent(event: WishEventModel) throws {
        guard let eventDescription = NSEntityDescription.entity(
            forEntityName: Constants.entityName,
            in: context
        ) else { throw EventManagerError.entityNotFound }
        let eventCoreData = Event(entity: eventDescription, insertInto: context)
        
        eventCoreData.eventTitle = event.title
        eventCoreData.eventDescription = event.description
        eventCoreData.startDate = event.startDate
        eventCoreData.endDate = event.endDate
        
        appDelegate.saveContext()
    }
    
    func fetchEvents() -> Result<[WishEventModel], EventManagerError> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: Constants.entityName
        )
        
        var events: [WishEventModel] = []
        if let eventsCoreData = try? context.fetch(fetchRequest) as? [Event] {
            eventsCoreData.forEach { eventCD in
                events.append(
                    WishEventModel(
                        title: eventCD.eventTitle ?? "",
                        description: eventCD.eventDescription ?? "",
                        startDate: eventCD.startDate ?? Date(),
                        endDate: eventCD.endDate ?? Date()
                    )
                )
            }
            return .success(events)
            } else { return .failure(.listOfEventsNotFound) }
    }
    
    func fetchEvent(withID id: Int) -> Result<WishEventModel, EventManagerError> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: Constants.entityName
        )
        do {
            let events = try context.fetch(fetchRequest) as? [Event]
            return .success(
                WishEventModel(
                    title: events?[id].eventTitle ?? "",
                    description: events?[id].eventDescription ?? "",
                    startDate: events?[id].startDate ?? Date(),
                    endDate: events?[id].endDate ?? Date()
                )
            )
        } catch { return .failure(.eventNotFound) }
    }
    
    func deleteEvent(withId id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: Constants.entityName
        )
        if let eventsCoreData = try? context.fetch(fetchRequest) as? [Event] {
            let eventToDelete = eventsCoreData[id]
            context.delete(eventToDelete)
            
            appDelegate.saveContext()
        }
    }
}
