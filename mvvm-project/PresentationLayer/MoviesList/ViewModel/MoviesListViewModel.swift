//
//  MoviesListViewModel.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 11/12/2021.
//

import Foundation

struct MoviesListViewModel {
    
    private let moviesAPIManager: MoviesAPIManagerProtocol
    
    init(moviesAPIManager: MoviesAPIManagerProtocol) {
        self.moviesAPIManager = moviesAPIManager
    }
    
    func getPopularMovies() {
        moviesAPIManager.getPopularMovies(page: 1) { response, error in
            if error == .noInternet {
                print ("jsdhfjahskdjask")
            }
        }
    }
    
}
