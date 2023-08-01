//
//  AppDelegate.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 29/07/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let homeViewModel = HomeViewModel()
        window?.rootViewController = UINavigationController(rootViewController: HomeController(viewModel: homeViewModel))
        return true
    }
}
