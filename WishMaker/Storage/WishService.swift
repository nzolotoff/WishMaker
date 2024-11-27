//
//  WishService.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 26.11.2024.
//

import Foundation

protocol WishServiceProtocol {
    func getWishes() -> [String]
    func addWish(_ wish: String)
    func editWish(at index: Int, to newWish: String)
    func deleteWish(at index: Int)
}

final class WishService: WishServiceProtocol {
    private let defaultsService: DefaultsServiceProtocol
    private var wishes: [String] = []
    
    init(defaultsService: DefaultsServiceProtocol = DefaultsService()) {
        self.defaultsService = defaultsService
        self.wishes = defaultsService.loadWishes()
    }
    
    func getWishes() -> [String] {
        return wishes
    }
    
    func addWish(_ wish: String) {
        wishes.append(wish)
        defaultsService.saveWishes(wishes)
    }
    
    func editWish(at index: Int, to newWish: String) {
        guard index >= 0 && index < wishes.count else { return }
        wishes[index] = newWish
        defaultsService.saveWishes(wishes)
    }
    
    func deleteWish(at index: Int) {
        guard index >= 0 && index < wishes.count else { return }
        wishes.remove(at: index)
        defaultsService.saveWishes(wishes)
    }
}
