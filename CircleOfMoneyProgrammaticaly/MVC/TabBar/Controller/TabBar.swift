//
//  TabBarViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit

class TabBar: SHCircleBarController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        self.selectedIndex = 0
    }

    //MARK: - Methods
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.barTintColor = UIColor(named: "greenGreatTint")

        navController.tabBarItem.image = image
        return navController
    }

    func setupVCs() {
        viewControllers = [
            createNavController(for: AccountsViewController(), image: UIImage(named: "accountsIcon")!),
            createNavController(for: HomeViewController(), image: UIImage(named: "mainIcon")!),
            createNavController(for: OperationsViewController(), image: UIImage(named: "operationsIcon")!)]
    }
}

