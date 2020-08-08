//
//  HeroDetailScreenInteractor.swift
//  ProHerald
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Foundation

protocol HeroDetailScreenInteractorInterface: class {
    func fetchRelatedHeroes(primaryAttribute: String, allHeros: [HeroDetailObject])
}

class HeroDetailScreenInteractor: HeroDetailScreenInteractorInterface {
    var presenter: HeroDetailScreenPresenterInterface?
            
    func fetchRelatedHeroes(primaryAttribute: String, allHeros: [HeroDetailObject]) {
        var relatedHeros: [HeroDetailObject] = []
        
        if primaryAttribute == "agi" {
            // sorted heroes with highest movement speed
            relatedHeros = allHeros.sorted(by: { fisrt, second in
                fisrt.moveSpeed ?? 0 > second.moveSpeed ?? 0
            })
        } else if primaryAttribute == "str" {
            // sorted heroes with highest base attack max
            relatedHeros = allHeros.sorted(by: { fisrt, second in
                fisrt.baseAttackMax ?? 0 > second.baseAttackMax ?? 0
            })
        } else if primaryAttribute == "int" {
            // sorted heroes with highest base mana
            relatedHeros = allHeros.sorted(by: { fisrt, second in
                fisrt.baseMana ?? 0 > second.baseMana ?? 0
            })
        }
        
        presenter?.onUpdateRelatedHeroes(heroes: relatedHeros.suffix(3))
    }
}
