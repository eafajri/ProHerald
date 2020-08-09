//
//  HomeScreenRouterTest.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 09/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Mockit
import Nimble
import Quick

@testable import ProHerald

class HomeScreenRouterTest: QuickSpec {
    override func spec() {
        describe("HomeScreenRouterTest") {
            var router: HomeScreenRouter!
            
            var mockedVC: HomeScreenVC!
            var mockedNavigationController: MockNavigationController!
            
            let mockedHero: HeroDetailObject = HeroDetailObject(coder: NSKeyedUnarchiver(forReadingWith: Data()))!
            
            beforeEach {
                router = HomeScreenRouter()
                
                mockedVC = HomeScreenVC()
                mockedNavigationController = MockNavigationController(rootViewController: mockedVC)
                
                router.viewController = HomeScreenVC()
                
                UIApplication.shared.keyWindow?.rootViewController = mockedNavigationController
            }
            
            context("routeToHeroDetailScreen") {
                it("should call pushViewController") {
                    router.routeToHeroDetailScreen(selectedHero: mockedHero, allHeroes: [])
                    
                    expect(mockedNavigationController.pushedViewController).toNot(beNil())
                }
            }
        }
    }
}
