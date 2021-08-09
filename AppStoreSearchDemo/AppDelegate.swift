//
//  AppDelegate.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/4/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window: UIWindow = .init()
        self.window = window
        
        let vc: ViewController = .init()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        return true
    }


}

