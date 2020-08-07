//
//  AppDelegate.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                        
        window = UIWindow(frame: UIScreen.main.bounds)

        let rootNC = UINavigationController(rootViewController: HomeScreenVC())
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
                
        return true
    }
}
