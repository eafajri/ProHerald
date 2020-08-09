//
//  HomeScreenPresenterTest.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 09/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Mockit
import Nimble
import Quick

@testable import ProHerald

class HomeScreenPresenterTest: QuickSpec {
    override func spec() {
        describe("HomeScreenPresenterTest") {
            var presenter: HomeScreenPresenter!
            var mockedVC: MockedHomeScreenVC!
            
            beforeEach {
                presenter = HomeScreenPresenter()
                mockedVC = MockedHomeScreenVC(testCase: self)
                
                presenter.viewController = mockedVC
            }
            
            context("onUpdateHeroes") {
                it("should call controller to reloadCollectionView") {
                    presenter.onUpdateHeroes(heroes: [])
                    
                    mockedVC.verify(verificationMode: Once()).reloadCollectionView(allHeroes: [])
                }
            }
            
            context("onUpdateFilteredHeroes") {
                it("should call controller to reloadCollectionView") {
                    presenter.onUpdateFilteredHeroes(filteredHeroes: [])
                    
                    mockedVC.verify(verificationMode: Once()).reloadCollectionView(filteredHeroes: [])
                }
            }
            
            context("onUpdateRoles") {
                it("should call controller to reloadRolesTableView") {
                    presenter.onUpdateRoles(roles: [])
                    
                    mockedVC.verify(verificationMode: Once()).reloadRolesTableView(displayedRoles: [])
                }
            }
            
            context("onGetError") {
                it("should call controller to showErrorMessage") {
                    presenter.onGetError(with: "")
                    
                    mockedVC.verify(verificationMode: Once()).showErrorMessage(with: "")
                }
            }
        }
    }
}
