//
//  AppDelegate.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 10/25/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

// @UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

// MARK: - Config
extension AppDelegate {

    enum RootType {
        case menu
    }

    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        setRoot(rootType: .menu)
    }

    func setRoot(rootType: RootType) {
        switch rootType {
        case .menu:
            window?.rootViewController = MenuVC()
        }
    }
}
