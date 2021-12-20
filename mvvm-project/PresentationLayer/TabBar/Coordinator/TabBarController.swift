//
//  TabBarController.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 18/12/2021.
//

import UIKit

struct TabBarModel {
    let tabBarItemImage: UIImage
    let tabBarItemName: String
    let viewController: UIViewController
}

class TabBarController: UITabBarController {

    // MARK: - Properties
    var coordinator = TabBarCoordinator()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
        handleTabs()
    }

    // MARK: - UI Configuration
    
    private func configureTabBar(){
        tabBar.backgroundColor = .white
    }
    
    private func handleTabs() {
        coordinator.configureTabBarModels()
        viewControllers = coordinator.viewControllers
    }
    
}
