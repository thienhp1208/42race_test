//
//  AppDelegate.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var appRouter = AppRouter(with: self.window!)
    lazy var appCoordinator = AppCoordinator(with: self.appRouter, session: self.session)
    let session = Session()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Init window first
        window = UIWindow()
        appCoordinator.start()
        
        return true
    }
}

