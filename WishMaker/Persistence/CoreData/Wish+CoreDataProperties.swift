//
//  Wish+CoreDataProperties.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 24.12.2024.
//
//

import Foundation
import CoreData

@objc(Wish)
public class Wish: NSManagedObject {

}

extension Wish {
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
}

extension Wish : Identifiable { }
