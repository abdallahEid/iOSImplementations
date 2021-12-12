//
//  MoviesListViewController.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 11/12/2021.
//

import UIKit

class MoviesListViewController: UIViewController {

    private let viewModel: MoviesListViewModel
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        self.viewModel.getPopularMovies()
    }
}
