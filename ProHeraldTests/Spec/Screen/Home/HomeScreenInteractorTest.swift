//
//  HomeScreenInteractorTest.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Mockit
import Nimble
import Quick

@testable import ProHerald

class HomeScreenInteractorTest: QuickSpec {
    override func spec() {
        describe("HomeScreenInteractorTest") {
            var interactor: HomeScreenInteractor!
            
            var mockedPresenter: MockedHomeScreenPresenter!
            var mockedNetworkManager: MockedNetworkManager!
            var mockedLocalStorageManager: MockedLocalStorageManager!
            
            let mockedHero: HeroDetailObject = HeroDetailObject(coder: NSKeyedUnarchiver(forReadingWith: Data()))!
            
            beforeEach {
                interactor = HomeScreenInteractor()
                
                mockedPresenter = MockedHomeScreenPresenter(testCase: self)
                mockedNetworkManager = MockedNetworkManager(testCase: self)
                mockedLocalStorageManager = MockedLocalStorageManager(testCase: self)
                
                interactor.presenter = mockedPresenter
                interactor.networkManager = mockedNetworkManager
                interactor.localStorageManager = mockedLocalStorageManager
            }
            
            context("fetchFromLocalStorage") {
                it("should call localStorageManager to fetch cache data") {
                    interactor.fetchAllHeroes()
                    
                    _ = mockedLocalStorageManager.verify(verificationMode: Once()).getHeroes()
                }
                
                it("should trigger presenter for updating when data is not empty") {
                    mockedLocalStorageManager.mockedHeroes = [mockedHero]
                    
                    interactor.fetchAllHeroes()
                    
                    mockedPresenter.verify(verificationMode: Once()).onUpdateHeroes(heroes: [])
                    mockedPresenter.verify(verificationMode: Once()).onUpdateRoles(roles: [])
                }
                
                it("should not trigger presenter for updating when data is empty") {
                    mockedLocalStorageManager.mockedHeroes = []
                    
                    interactor.fetchAllHeroes()
                    
                    mockedPresenter.verify(verificationMode: Never()).onUpdateHeroes(heroes: [])
                    mockedPresenter.verify(verificationMode: Never()).onUpdateRoles(roles: [])
                }
            }
            
            context("fetchFromServer") {
                it("should check internet connection") {
                    interactor.fetchAllHeroes()
                    
                    _ = mockedNetworkManager.verify(verificationMode: Once()).isConnectedToInternet()
                }
                
                context("no internet access") {
                    it("should call network manager for getting data") {
                        _ = mockedNetworkManager.when().call(
                            withReturnValue: mockedNetworkManager.isConnectedToInternet(),
                            andArgumentMatching: []
                        ).thenReturn(false)
                        
                        interactor.fetchAllHeroes()
                        
                        mockedPresenter.verify(verificationMode: Once()).onGetError(with: "")
                    }
                }
                
                context("have internet access") {
                    beforeEach {
                        _ = mockedNetworkManager.when().call(
                             withReturnValue: mockedNetworkManager.isConnectedToInternet(),
                             andArgumentMatching: []
                         ).thenReturn(true)
                    }
                    
                    it("should trigger presenter for updating data when success fetch data") {
                        _ = mockedNetworkManager.when().call(
                            withReturnValue: mockedNetworkManager.fetchAllHeroes(
                                onSuccess: { _ in },
                                onError: { _ in }
                            ),
                            andArgumentMatching: [Anything(), Anything()]
                        ).thenDo { arguments in
                            guard let onSuccess = arguments.first as? (([HeroDetailObject]) -> Void) else { return }
                            onSuccess([])
                        }

                        interactor.fetchAllHeroes()

                        mockedPresenter.verify(verificationMode: Once()).onUpdateHeroes(heroes: [])
                        mockedPresenter.verify(verificationMode: Once()).onUpdateRoles(roles: [])
                    }
                    
                    it("should trigger presenter for for getting error when error fetch data") {
                        _ = mockedNetworkManager.when().call(
                            withReturnValue: mockedNetworkManager.fetchAllHeroes(
                                onSuccess: { _ in },
                                onError: { _ in }
                            ),
                            andArgumentMatching: [Anything(), Anything()]
                        ).thenDo { arguments in
                            guard let onError = arguments.last as? ((String) -> Void) else { return }
                            onError("")
                        }

                        interactor.fetchAllHeroes()

                        mockedPresenter.verify(verificationMode: Never()).onUpdateHeroes(heroes: [])
                        mockedPresenter.verify(verificationMode: Never()).onUpdateRoles(roles: [])
                    }
                }
            }
        }
    }
}
