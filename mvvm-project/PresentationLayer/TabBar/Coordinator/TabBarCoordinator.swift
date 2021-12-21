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
    
    private var photosListMVCViewController: UIViewController {
        let listViewController = PhotoListMVCTableViewController()
        listViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        let navController = UINavigationController(rootViewController: listViewController)
        
        return navController
    }
    
    private var photosListViewController: UIViewController {
        let listViewModel = PhotoListViewModel(listPhotosAPIManager: ListPhotoAPIManager())
        let listViewController = PhotoListViewController(viewModel: listViewModel)
        listViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        let navController = UINavigationController(rootViewController: listViewController)
        
        return navController
    }
        
    // MARK: - TabBar Models Configuiration
    func configureTabBarModels(){
        viewControllers.append(photosListViewController)
        viewControllers.append(photosListMVCViewController)
    }
    
}
