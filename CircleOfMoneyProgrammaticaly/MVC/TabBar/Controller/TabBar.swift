//
//  TabBarViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit

protocol GetRootNavDelegate {
    func getRootNav() -> UINavigationController?
}

class TabBar: SHCircleBarController {

    //MARK: - Variables
    var firstNavigationController: UINavigationController?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        //UITabBar.appearance().barTintColor = .systemBackground
        //tabBar.tintColor = .label
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
        let accountsViewController = AccountsViewController()
        accountsViewController.delegate = self
        let homeViewController = HomeViewController()
        homeViewController.delegate = self
        let operationsViewController = OperationsViewController()
        operationsViewController.delegate = self

        viewControllers = [
            createNavController(for: accountsViewController, image: UIImage(named: "accountsIcon")!),
            createNavController(for: homeViewController, image: UIImage(named: "mainIcon")!),
            createNavController(for: operationsViewController, image: UIImage(named: "operationsIcon")!)]
    }
}

extension TabBar: GetRootNavDelegate {
    func getRootNav() -> UINavigationController? {
        return self.firstNavigationController ?? nil
    }
}
