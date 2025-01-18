//
//  DefaultsService.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 26.11.2024.
//

import Foundation

protocol DefaultsManagerLogic {
    func set<T>(forKey key: String, value: T)
    func get<T>(forKey key: String, defaultValue: T) -> T
    func removeObject(forKey key: String)
}

final class DefaultsManager: DefaultsManagerLogic {
    private let defaults = UserDefaults.standard
    
    func set<T>(forKey key: String, value: T) {
        defaults.set(value, forKey: key)
    }
    
    func get<T>(forKey key: String, defaultValue: T) -> T {
        defaults.object(forKey: key) as? T ?? defaultValue
    }
    
    func removeObject(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
