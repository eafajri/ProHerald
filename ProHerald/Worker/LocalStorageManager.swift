//
//  LocalStorageManager.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Foundation
import PINCache

enum LocalStorageKey: String {
    case allOfHeroes = "all_of_heroes"
}

class LocalStorageManager {
    static var shared: LocalStorageManager = LocalStorageManager()
    
    func saveHeroes(with heroes: [HeroDetailObject]) {
        PINCache.shared().setObject((heroes as NSArray), forKey: LocalStorageKey.allOfHeroes.rawValue)
    }
    
    func getHeroes() -> [HeroDetailObject] {
        guard let result: [HeroDetailObject] = PINCache.shared().object(forKey: LocalStorageKey.allOfHeroes.rawValue) as? [HeroDetailObject] else {
            return []
        }
        
        return result
    }
}
