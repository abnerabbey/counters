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
        defaultNavBarAppearance()
        
        window = UIWindow()
        appDependencyContainer = DependencyContainer(window: window!)
        mainCoordinator = appDependencyContainer.makeMainCoordinator()
        mainCoordinator.start()
        
        return true
    }
    
    private func defaultNavBarAppearance() {
        if #available(iOS 15, *) {
            let appereance = UINavigationBarAppearance()
            appereance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appereance
            UINavigationBar.appearance().scrollEdgeAppearance = appereance
            
        }
    }
}

