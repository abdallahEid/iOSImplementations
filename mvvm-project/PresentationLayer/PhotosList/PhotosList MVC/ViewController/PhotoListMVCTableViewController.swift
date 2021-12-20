//
//  PhotoListMVCTableViewController.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import UIKit

class PhotoListMVCTableViewController: UITableViewController {

    // MARK: - Properties
    private var users = [User]()
    private var currentPage = 0

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        getPhotos()
    }
    
    // MARK: - UI Configuration 
    private func configureTableView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }
    
    // MARK: - API Calls
    private func getPhotos(){
        
        currentPage += 1
        ListPhotoAPIManager().getPhotosList(page: currentPage) { apiResponses, error in
            
            guard let apiResponses = apiResponses else {
                return
            }

            for apiResponse in apiResponses {
                var response = apiResponse
                response.user.createdAt = response.createdAt
                self.users.append(response.user)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.stopLoading()
            }
        }
    }
}

// MARK: - TableView Delegate and DataSource
extension PhotoListMVCTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell {
    
            let currentUser = users[indexPath.row]
            
            var dateToBeShown = "No Available Date"
           
            let inFormatter = DateFormatter()
            inFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            let outFormatter = DateFormatter()
            outFormatter.dateFormat = "dd/MM/yy"
             
            if let dateStr = currentUser.createdAt,
               let date = inFormatter.date(from: dateStr) {
                dateToBeShown = outFormatter.string(from: date)
            }
        
            cell.model = PhotoInformationModel(imageUrl: currentUser.profileImage.large, description: currentUser.instagramUsername ?? "Description here", name: currentUser.name, date: dateToBeShown)
            
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.addLoading(indexPath) { [weak self] in
            self?.getPhotos()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
