//
//  PhotoListViewController.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import UIKit
import ProgressHUD

class PhotoListViewController: UITableViewController {

    // MARK: - Properties
    private let viewModel: PhotoListViewModel
    private var routeToPhotoDetails: RouteToPhotoDetails?
    
    // MARK: - Initialization
    init(viewModel: PhotoListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        initializeViewModel()
    }
    
    // MARK: - UI Configuration
    private func configureTableView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }
}

// MARK: - Data Binding
extension PhotoListViewController {
    private func initializeViewModel(){
        observeForDataFetch()
        ProgressHUD.show()
        viewModel.fetchPhotos()
    }
    
    private func observeForDataFetch(){
        viewModel.didFetchDataSuccessfully = { [weak self] models in
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.didFetchDataFailure = { [weak self] error in
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - Routing
extension PhotoListViewController {
    private func navigateToPhotoDetails(index: Int){
        let isUserAvailableToHire = viewModel.isUserAvailableToHire(index: index)
        let userImageUrl = viewModel.getImageForUser(index: index)
        
        routeToPhotoDetails = RouteToPhotoDetails(isUserAvailableToHire: isUserAvailableToHire, userImageUrl: userImageUrl)
        routeToPhotoDetails?.route(from: self)
    }
}

// MARK: - Table View Delegates & Data Source
extension PhotoListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell {
        
            cell.model = viewModel.getPhotoInformationModel(index: indexPath.row)
            return cell
        }
        
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToPhotoDetails(index: indexPath.row)
    }
}
