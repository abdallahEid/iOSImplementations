//
//  PopularMoviesAPIManager.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 15/12/2021.
//

import Foundation

protocol MoviesAPIManagerProtocol {
    func getPopularMovies(page: Int, completion: @escaping (MovieApiResponse?, NetworkError?) -> ())
}

struct PopularMoviesAPIManager: MoviesAPIManagerProtocol {
    func getPopularMovies(page: Int, completion: @escaping (MovieApiResponse?, NetworkError?) -> ()) {
        
        let endPoint = PopularMoviesEndPoint()
        Router().request(endPoint) { result in
            switch result {
            case .success(let data):
                let decodeResult = endPoint.decoder.decode(responseData: data)
                switch decodeResult {
                case .success(let moviesAPIResponse):
                    if let response = moviesAPIResponse as? MovieApiResponse {
                        completion(response, nil)
                    } else {
                        completion(nil, .unableToDecode)
                    }
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
                }
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
}
