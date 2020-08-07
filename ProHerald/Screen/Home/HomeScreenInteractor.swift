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
        let dataFromLocalStorage = LocalStorageManager.shared.getHeroes()
        
        
        NetworkManager.shared.fetchAllHeroes(
            onSuccess: { heroes in
                LocalStorageManager.shared.saveHeroes(with: heroes)
            }, onError: { error in
                
            }
        )
    }
}
