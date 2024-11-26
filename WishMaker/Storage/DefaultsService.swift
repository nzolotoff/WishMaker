//
//  DefaultsService.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 26.11.2024.
//

import Foundation

protocol DefaultsServiceProtocol {
    func saveWishes(_ wishes: [String])
    func loadWishes() -> [String]
}

final class DefaultsService: DefaultsServiceProtocol {
    private enum Keys {
        static let wishes: String = "userWishes"
    }
    
    func saveWishes(_ wishes: [String]) {
        UserDefaults.standard.set(wishes, forKey: Keys.wishes)
    }
    
    func loadWishes() -> [String] {
        UserDefaults.standard.array(forKey: Keys.wishes) as? [String] ?? []
    }
}
