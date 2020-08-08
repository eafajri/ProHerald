//
//  HomeScreenPresenter.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

protocol HomeScreenPresenterInterface: class {
    func onUpdateHeroes(heroes: [HeroDetailObject])
    func onUpdateRoles(roles: [String])
    func onGetError(with message: String)
}

class HomeScreenPresenter: HomeScreenPresenterInterface {
    var viewController: HomeScreenVC?
    
    func onUpdateHeroes(heroes: [HeroDetailObject]) {
        viewController?.reloadCollectionView(displayedHeroes: heroes)
    }
    
    func onUpdateRoles(roles: [String]) {
        viewController?.reloadRolesTableView(displayedRoles: roles)
    }
    
    func onGetError(with message: String) {
        PopUpMessageView.shared.showAlert(message: message)
    }
}
