//
//  HomeScreenInteractorTest.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Fakery
import Nimble
import Quick

@testable import ProHerald

class HomeScreenInteractorTest: QuickSpec {
    override func spec() {
        describe("HomeScreenInteractorTest") {
            var interactor: HomeScreenInteractor!
            var presenter: HomeScreenPresenter?
            
            beforeEach {
                interactor = HomeScreenInteractor()
                presenter = HomeScreenPresenter()
                
                interactor.presenter = presenter
            }
            
            context("fetchFromLocalStorage") {
                it("should trigger presenter when data is not empty") {
                    
                }
                
                it("should not trigger presenter when data is empty") {
                    
                }
            }
            
            context("fetchFromServer") {
                
            }
        }
    }
}
