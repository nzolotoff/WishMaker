//
//  Event+CoreDataProperties.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 04.02.2025.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var eventDescription: String?
    @NSManaged public var eventTitle: String?
    @NSManaged public var id: UUID?
    @NSManaged public var startDate: Date?

}

extension Event : Identifiable {

}
