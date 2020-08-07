//
//  HomeScreenPresenter.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

protocol HomeScreenPresenterInterface: class {
    func reloadView()
}

class HomeScreenPresenter: HomeScreenPresenterInterface {
    var viewController: HomeScreenVC?
    
    func reloadView() {

    }
}
