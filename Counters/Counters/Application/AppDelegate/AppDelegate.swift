//
//  AppDelegate.swift
//  Counters
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appDependencyContainer: DependencyContainer!
    var mainCoordinator: MainCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        appDependencyContainer = DependencyContainer(window: window!)
        mainCoordinator = appDependencyContainer.makeMainCoordinator()
        mainCoordinator.start()
        
        return true
    }
}

