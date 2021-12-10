//
//  AppDelegate.swift
//  Counters
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appDependencyContainer: DependencyContainer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /*

        let window = UIWindow()
        let presenter = WelcomeViewPresenter()
        window.rootViewController = WelcomeViewController(presenter: presenter)
        self.window = window
        window.makeKeyAndVisible()
        return true */
        window = UIWindow()
        appDependencyContainer = DependencyContainer(window: window!)
        
        return true
    }
}

