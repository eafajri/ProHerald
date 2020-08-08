//
//  HomeScreenRouter.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit

protocol HomeScreenRouterInterface {
    func routeToHeroDetailScreen(selectedHero: HeroDetailObject, allHeroes: [HeroDetailObject])
}

class HomeScreenRouter: HomeScreenRouterInterface {
    weak var viewController: HomeScreenVC?
    
    func routeToHeroDetailScreen(selectedHero: HeroDetailObject, allHeroes: [HeroDetailObject]) {
        
        let detailVC = HeroDetailScreenVC()
        detailVC.screenState.heroDetail = selectedHero
        detailVC.screenState.allHeros = allHeroes
        
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
