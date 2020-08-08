//
//  MockedNetworkManager.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Mockit
import XCTest

@testable import ProHerald

class MockedNetworkManager: NetworkManager, Mock {
    var callHandler: CallHandler
    typealias InstanceType = MockedNetworkManager
    
    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    
    func instanceType() -> MockedNetworkManager {
        return self
    }
    
    override func isConnectedToInternet() -> Bool {
        return callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: nil
        ) as? Bool ?? false
    }
    
    override func fetchAllHeroes(onSuccess: @escaping ([HeroDetailObject]) -> Void, onError: @escaping (String) -> Void) {
        _ = callHandler.accept(
            nil,
            ofFunction: #function,
            atFile: #file,
            inLine: #line,
            withArgs: onSuccess, onError
        )
    }
}
