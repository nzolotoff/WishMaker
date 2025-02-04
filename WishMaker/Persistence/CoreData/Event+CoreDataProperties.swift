//
//  Event+CoreDataProperties.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 03.02.2025.
//
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject { }

extension Event {
    @NSManaged public var endDate: Date?
    @NSManaged public var startDate: Date?
    @NSManaged public var eventDescription: String?
    @NSManaged public var eventTitle: String?
}

extension Event : Identifiable { }
