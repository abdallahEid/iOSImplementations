//
//  MoviesAPIManager.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import Foundation

protocol MoviesAPIManagerProtocol {
    func getPopularMovies(page: Int, completion: @escaping (MovieApiResponse?, NetworkError?) -> ())
}

struct MoviesAPIManager: MoviesAPIManagerProtocol {
    func getPopularMovies(page: Int, completion: @escaping (MovieApiResponse?, NetworkError?) -> ()) {
        
        Router().request(MoviesPopularEndPoint()) { (result: Result<MovieApiResponse, NetworkError>) in
            switch result {
            case .success(let moviesAPIResponse):
                completion(moviesAPIResponse, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
