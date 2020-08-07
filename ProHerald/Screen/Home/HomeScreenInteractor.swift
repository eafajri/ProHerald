//
//  HomeScreenInteractor.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

protocol HomeScreenInteractorInterface: class {
    func fetch()
}

class HomeScreenInteractor: HomeScreenInteractorInterface {
    var presenter: HomeScreenPresenterInterface?
            
    func fetch() {
        NetworkManager.shared.fetchAllHeroes(
            onSuccess: { heroes in
                print(heroes)
            }, onError: { error in
                
            }
        )
    }
}
