//
//  AppDelegate.swift
//  Weather
//
//  Created by Даниил Гетманцев on 25.11.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           self.window = UIWindow(frame: UIScreen.main.bounds)
           let navVc = UINavigationController(rootViewController: ShowWeatherViewController())
           window?.rootViewController = navVc
        window?.makeKeyAndVisible()
        return true
    }
}

