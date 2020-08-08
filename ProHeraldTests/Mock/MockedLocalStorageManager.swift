//
//  MockedLocalStorageManager.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Mockit
import XCTest

@testable import ProHerald

class MockedLocalStorageManager: LocalStorageManager, Mock {
    var callHandler: CallHandler
    typealias InstanceType = MockedLocalStorageManager
    
    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    
    func instanceType() -> MockedLocalStorageManager {
        return self
    }
    
    override func saveHeroes(with heroes: [HeroDetailObject]) {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: heroes
        )
    }
    
    override func getHeroes() -> [HeroDetailObject] {
        return callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: nil
        ) as? [HeroDetailObject] ?? []
    }
}
