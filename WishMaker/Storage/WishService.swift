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
}
