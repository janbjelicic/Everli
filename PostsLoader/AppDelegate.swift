//
//  AppDelegate.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        AppManager.shared.imageManager.clearCache()
    }

}
