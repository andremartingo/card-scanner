//
//  AppDelegate.swift
//  airpods-viewcontroller
//
//  Created by André Martingo on 24/11/2018.
//  Copyright © 2018 André Martingo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let home = ViewController()
        let navigation = UINavigationController(rootViewController: home)
        window?.rootViewController = navigation
        return true
    }
}

