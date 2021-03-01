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
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)

        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        //rootViewController.navigationItem.title = title

        return navController
    }

    func setupVCs() {
        viewControllers = [
            createNavController(for: AccountsViewController(), image: UIImage(named: "accountsIcon")!),
            createNavController(for: HomeViewController(), image: UIImage(named: "mainIcon")!),
            createNavController(for: OperationsViewController(), image: UIImage(named: "operationsIcon")!)]
    }
}

