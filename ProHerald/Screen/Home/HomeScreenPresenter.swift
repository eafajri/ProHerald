//
//  HomeScreenPresenter.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

protocol HomeScreenPresenterInterface: class {
    func onUpdateHeroes(heroes: [HeroDetailObject])
    func onUpdateFilteredHeroes(filteredHeroes: [HeroDetailObject])
    func onUpdateRoles(roles: [String])
    func onGetError(with message: String)
}

class HomeScreenPresenter: HomeScreenPresenterInterface {
    var viewController: HomeScreenVCInterface?
    
    func onUpdateHeroes(heroes: [HeroDetailObject]) {
        viewController?.reloadCollectionView(allHeroes: heroes)
    }
    
    func onUpdateFilteredHeroes(filteredHeroes: [HeroDetailObject]) {
        viewController?.reloadCollectionView(filteredHeroes: filteredHeroes)
    }
    
    func onUpdateRoles(roles: [String]) {
        viewController?.reloadRolesTableView(displayedRoles: roles)
    }
    
    func onGetError(with message: String) {
        viewController?.showErrorMessage(with: message)
    }
}
