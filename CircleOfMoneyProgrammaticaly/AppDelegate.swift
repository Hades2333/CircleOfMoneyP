//
//  AppDelegate.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 19.02.21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        if let window = self.window {
            let navigationController = UINavigationController()
            navigationController.viewControllers = [FirstScreenViewController()]

            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        return true
    }
}

