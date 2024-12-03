//
//  WishService.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 26.11.2024.
//

import Foundation

enum Keys {
    static let wishes: String = "userWishes"
}

protocol WishServiceLogic {
    func getWishes() -> [String]
    func addWish(_ wish: String)
    func editWish(at index: Int, to newWish: String)
    func deleteWish(at index: Int)
}

final class WishService: WishServiceLogic {
    private let defaultsService: DefaultsServiceLogic
    private var wishes: [String]
    
    init(defaultsService: DefaultsServiceLogic = DefaultsService()) {
        self.defaultsService = defaultsService
        self.wishes = defaultsService.get(forKey: Keys.wishes, defaultValue: [])
    }
    
    func getWishes() -> [String] {
        return wishes
    }
    
    func addWish(_ wish: String) {
        wishes.append(wish)
        defaultsService.set(forKey: Keys.wishes, value: wishes)
    }
    
    func editWish(at index: Int, to newWish: String) {
        guard index >= 0 && index < wishes.count else { return }
        wishes[index] = newWish
        defaultsService.set(forKey: Keys.wishes, value: wishes)
    }
    
    func deleteWish(at index: Int) {
        guard index >= 0 && index < wishes.count else { return }
        wishes.remove(at: index)
        defaultsService.set(forKey: Keys.wishes, value: wishes)
    }
}
