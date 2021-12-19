//
//  PhotoListMVCTableViewController.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import UIKit

class PhotoListMVCTableViewController: UITableViewController {

    // MARK: - Properties
    let photos = [Photo]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }

}

// MARK: - TableView Delegate and DataSource
extension PhotoListMVCTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell {
         
            cell.model = PhotoTableViewCellModel(imageUrl: "https://drscdn.500px.org/photo/230200335/w%3D280_h%3D280/v2?client_application_id=11&user_id=824357&webp=true&v=0&sig=87c378f20802362700eba08bf18c5ac001b5fa4a67c90b613b38b7fe7138bd8c", description: "Test", name: "Test", date: "Test")
            
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
