//
//  PhotoListRouter.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 20/12/2021.
//

import UIKit

struct RouteToPhotoDetails {
    
    // MARK: - Properties
    private let isUserAvailableToHire: Bool
    private let userImageUrl: String
    
    // MARK: - Initialization
    init(isUserAvailableToHire: Bool, userImageUrl: String){
        self.isUserAvailableToHire = isUserAvailableToHire
        self.userImageUrl = userImageUrl
    }
    
    // MARK: - Helpers 
    private func routeToPhotoDetails(sourceViewController: UIViewController){
        let vc = PhotoDetailViewController(imageUrl: userImageUrl)
        sourceViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showErrorAlert(sourceViewController: UIViewController) {
        let alert = UIAlertController(title: "Not for hire", message: "This person is not for hire", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        sourceViewController.present(alert, animated: true, completion: nil)
    }
}


// MARK: - Router Protocol
extension RouteToPhotoDetails: Router{
    func route(from sourceViewController: UIViewController) {
        if isUserAvailableToHire {
            routeToPhotoDetails(sourceViewController: sourceViewController)
        } else {
            showErrorAlert(sourceViewController: sourceViewController)
        }
    }
}
