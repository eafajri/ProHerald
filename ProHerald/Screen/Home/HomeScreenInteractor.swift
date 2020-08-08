//
//  HomeScreenInteractor.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Foundation

protocol HomeScreenInteractorInterface: class {
    func fetch()
}

class HomeScreenInteractor: HomeScreenInteractorInterface {
    var presenter: HomeScreenPresenterInterface?
            
    func fetch() {
        fetchFromLocalStorage()
        fetchFromServer()
    }
    
    private func fetchFromLocalStorage() {
        let heroes: [HeroDetailObject] = LocalStorageManager.shared.getHeroes()
        let roles: [String] = getAllHeroRoles(from: heroes)
        
        presenter?.onUpdateHeroes(heroes: heroes)
        presenter?.onUpdateRoles(roles: roles)
    }
    
    private func fetchFromServer() {
        guard NetworkManager.shared.isConnectedToInternet() else {
            presenter?.onGetError(with: "No internet connections")
            return
        }
        
        NetworkManager.shared.fetchAllHeroes(
            onSuccess: { [weak self] heroes in
                guard let s = self else { return }
                let roles: [String] = s.getAllHeroRoles(from: heroes)
                
                s.presenter?.onUpdateHeroes(heroes: heroes)
                s.presenter?.onUpdateRoles(roles: roles)
                
                LocalStorageManager.shared.saveHeroes(with: heroes)
            }, onError: { [weak self] message in
                self?.presenter?.onGetError(with: message)
            }
        )
    }
    
    private func getAllHeroRoles(from heroes: [HeroDetailObject]) -> [String] {
        var set: Set = Set<String>()
        
        for item in heroes {
            for role in item.roles {
                set.insert(role)
            }
        }
        
        return Array(set).sorted()
    }
}
