//
//  HeroDetailScreenPresenter.swift
//  ProHerald
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

protocol HeroDetailScreenPresenterInterface: class {
    func onUpdateRelatedHeroes(heroes: [HeroDetailObject])
}

class HeroDetailScreenPresenter: HeroDetailScreenPresenterInterface {
    var viewController: HeroDetailScreenVCInterface?
    
    func onUpdateRelatedHeroes(heroes: [HeroDetailObject]) {
        viewController?.reloadTableView(relatedHeroes: heroes)
    }
}
