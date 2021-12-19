//
//  TabBarCoordinator.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 18/12/2021.
//

import Foundation
import UIKit

class TabBarCoordinator {
    
    // MARK: - Properties
    var viewControllers = [UIViewController]()
        
    // MARK: - TabBar Models Configuiration
    func configureTabBarModels(){
        
        // Red
        let listViewController = PhotoListMVCTableViewController()
        listViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        let redNavigateionController = UINavigationController(rootViewController: listViewController)
        
        viewControllers.append(redNavigateionController)
        
        // Green
        let greenController = UIViewController()
        greenController.view.backgroundColor = .green
        greenController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        let greenNavigateionController = UINavigationController(rootViewController: greenController)
    
        viewControllers.append(greenNavigateionController)

    }
    
}
