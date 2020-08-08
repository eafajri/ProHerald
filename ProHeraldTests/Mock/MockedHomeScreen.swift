//
//  MockedHomeScreen.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Mockit
import XCTest

@testable import ProHerald

class MockedHomeScreenVC: HomeScreenVCInterface, Mock {
    var callHandler: CallHandler
    typealias InstanceType = MockedHomeScreenVC
    
    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    
    func instanceType() -> MockedHomeScreenVC {
        return self
    }
    
    func reloadCollectionView(allHeroes: [HeroDetailObject]) {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: allHeroes
        )
    }
    
    func reloadCollectionView(filteredHeroes: [HeroDetailObject]) {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: filteredHeroes
        )
    }
    
    func reloadRolesTableView(displayedRoles: [String]) {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: displayedRoles
        )
    }
    
    func showErrorMessage(with message: String) {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: message
        )
    }
}

class MockedHomeScreenInteractor: HomeScreenInteractorInterface, Mock {
    var callHandler: CallHandler
    typealias InstanceType = MockedHomeScreenInteractor
    
    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    
    func instanceType() -> MockedHomeScreenInteractor {
        return self
    }
    
    func fetchAllHeroes() {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: nil
        )
    }
    
    func proceedFilteredHeroes(allHeroes: [HeroDetailObject], roles: Set<String>) {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: allHeroes, roles
        )
    }
}

class MockedHomeScreenRouter: HomeScreenRouterInterface, Mock {
    var callHandler: CallHandler
    typealias InstanceType = MockedHomeScreenRouter
    
    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    
    func instanceType() -> MockedHomeScreenRouter {
        return self
    }
    
    func routeToHeroDetailScreen(selectedHero: HeroDetailObject, allHeroes: [HeroDetailObject]) {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: selectedHero, allHeroes
        )
    }
}
