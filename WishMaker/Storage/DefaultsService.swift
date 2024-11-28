//
//  DefaultsService.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 26.11.2024.
//

import Foundation

protocol DefaultsServiceProtocol {
    func saveWishes(for key: String, _ wishes: [String])
    func loadWishes(for key: String) -> [String]
}

final class DefaultsService: DefaultsServiceProtocol {
    
    func saveWishes(for key: String, _ wishes: [String]) {
        UserDefaults.standard.set(wishes, forKey: key)
    }
    
    func loadWishes(for key: String) -> [String] {
        UserDefaults.standard.array(forKey: key) as? [String] ?? []
    }
}
