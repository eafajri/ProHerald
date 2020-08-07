//
//  HomeScreenRouter.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit

protocol HomeScreenRouterInterface {
    func routeToHeroDetailScreen()
}

class HomeScreenRouter: HomeScreenRouterInterface {
    weak var viewController: HomeScreenVC?
    
    func routeToHeroDetailScreen() {
        
    }
}
