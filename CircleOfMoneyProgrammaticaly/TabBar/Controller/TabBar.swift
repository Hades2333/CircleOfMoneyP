//
//  TabBarViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit
import CircleBar

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        self.selectedIndex = 1
    }

    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)

        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title

        return navController
    }

    func setupVCs() {
        viewControllers = [
            createNavController(for: AccountsViewController(), title: NSLocalizedString("Accounts", comment: ""), image: UIImage(named: "accountsIcon")!),
            createNavController(for: HomeViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(named: "mainIcon")!),
            createNavController(for: OperationsViewController(), title: NSLocalizedString("Operations", comment: ""), image: UIImage(named: "operationsIcon")!)]
    }
}

