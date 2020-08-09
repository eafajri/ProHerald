//
//  MockedNavigationController.swift
//  ProHeraldTests
//
//  Created by erric alfajri on 09/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Mockit
import XCTest

@testable import ProHerald

class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
    }
}
