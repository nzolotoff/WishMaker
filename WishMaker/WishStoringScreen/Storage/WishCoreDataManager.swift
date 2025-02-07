//
//  WishStorageManager.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 24.12.2024.
//

import Foundation
import UIKit
import CoreData

protocol WishCoreDataManagerLogic {
    func createWish(withId id: Int16, title: String) throws
    func fetchWishes() -> Result<[Wish], WishManagerError>
    func fetchWish(withId id: Int16) -> Wish?
    func updateWish(withId id: Int16, to newTitle: String)
    func deleteAllWishes()
    func deleteWish(withId id: Int16)
}

// MARK: - Type of error
public enum WishManagerError: Error {
    case entityNotFound
    case listOfWishesNotFound
}
public final class WishCoreDataManager: WishCoreDataManagerLogic {
    // MARK: - Constants
    enum Constants {
        static let entityName: String = "Wish"
    }
    
    // MARK: - Singleton
    public static let shared = WishCoreDataManager()
    private init() { }
    
    // MARK: - Variables
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistenceContainer.viewContext
    }
    
    // MARK: CRUD Methods
    func createWish(withId id: Int16, title: String) throws {
        guard let wishDescription = NSEntityDescription.entity(
            forEntityName: Constants.entityName,
            in: context
        ) else {
            throw WishManagerError.entityNotFound
        }
        let wish = Wish(entity: wishDescription, insertInto: context)
        wish.id = id
        wish.title = title
        
        appDelegate.saveContext()
    }
    
    func fetchWishes() -> Result<[Wish], WishManagerError> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        if let wishes = try? context.fetch(fetchRequest) as? [Wish] {
            return .success(wishes)
        } else {
            return .failure(.listOfWishesNotFound)
        }
    }
    
    func fetchWish(withId id: Int16) -> Wish? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        guard let wish = try? context.fetch(
            fetchRequest
        ).first as? Wish else {
            return nil
        }
        return wish
    }
    
    func updateWish(withId id: Int16, to newTitle: String) {
        if case .success(let wishes) = fetchWishes() {
            wishes[Int(id)].title = newTitle
        }
        appDelegate.saveContext()
    }
    
    func deleteAllWishes() {
        let wishes = fetchWishes()
        switch wishes {
        case .success(let wishes):
            wishes.forEach { wish in
                context.delete(wish)
            }
        case .failure(let error):
            print(error)
        }
        appDelegate.saveContext()
    }
    
    func deleteWish(withId id: Int16) {
        if case .success(let wishes) = fetchWishes() {
            let wishToDelete = wishes[Int(id)]
            context.delete(wishToDelete)
        }
        appDelegate.saveContext()
    }
}
