//
//  HomeScreenVCTest.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 09/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Mockit
import Nimble
import Quick

@testable import ProHerald

class HomeScreenVCTest: QuickSpec {
    override func spec() {
        describe("HomeScreenVCTest") {
            typealias ViewID = HomeScreenVC.ViewIdentifier
            
            var vc: HomeScreenVC!
            
            var mockedRouter: MockedHomeScreenRouter!
            var mockedInteractor: MockedHomeScreenInteractor!
            
            let mockedHero: HeroDetailObject = HeroDetailObject(coder: NSKeyedUnarchiver(forReadingWith: Data()))!
            
            beforeEach {
                vc = HomeScreenVC()
                
                mockedRouter = MockedHomeScreenRouter(testCase: self)
                mockedInteractor = MockedHomeScreenInteractor(testCase: self)
                
                vc.injectService(
                    interactor: mockedInteractor,
                    router: mockedRouter
                )
            }
            
            context("loadView") {
                beforeEach {
                    vc.loadView()
                }
                
                it("should update screen title") {
                    expect(vc.title).toNot(beNil())
                }
                
                it("should render collection view") {
                    let collectionView = vc.view.subviews.first(where: { view in
                        view.accessibilityIdentifier == ViewID.heroesCollectionView.rawValue
                    })
                    
                    expect(collectionView).toNot(beNil())
                }
                it("should render table view") {
                    let tableView = vc.view.subviews.first(where: { view in
                        view.accessibilityIdentifier == ViewID.rolesTableView.rawValue
                    })
                    
                    expect(tableView).toNot(beNil())
                }
            }
            
            context("viewDidLoad") {
                beforeEach {
                    vc.viewDidLoad()
                }
                
                it("should call interactor to fetchAllHeroes") {
                    mockedInteractor.verify(verificationMode: Once()).fetchAllHeroes()
                }
            }
            
            context("onPullToRefresh") {
                beforeEach {
                    vc.onPullToRefresh()
                }
                
                it("should call interactor to fetchAllHeroes") {
                    mockedInteractor.verify(verificationMode: Once()).fetchAllHeroes()
                }
            }
            
            context("onTapHeroCard") {
                beforeEach {
                    vc.onTapHeroCard(selectedHero: mockedHero)
                }
                
                it("should call router to routeToHeroDetailScreen") {
                    mockedRouter.verify(verificationMode: Once()).routeToHeroDetailScreen(selectedHero: mockedHero, allHeroes: [])
                }
            }
            
            context("onTapHeroRole") {
                beforeEach {
                    vc.screenState.displayedRoles = [""]
                    vc.onTapHeroRole(at: IndexPath(row: 0, section: 0))
                }
                
                it("should call interactor to proceedFilteredHeroes") {
                    mockedInteractor.verify(verificationMode: Once()).proceedFilteredHeroes(allHeroes: [], roles: Set())
                }
            }
        }
    }
}
