//
//  MoviesEndPoint.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import Foundation

struct MoviesPopularEndPoint: EndPointType {
    
    // MARK: - Properties
    private var apiKey: String {
        return "34598197fdde2c0e7acc2c41bc1a18ab"
    }
    
    var baseUrl: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "movie/popular"
    }
    
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil,
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: ["api_key":apiKey
                                                 ])
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

//enum MoviesEndPoint: EndPointType {
//    
//    // MARK: - Routes
//    case recommended(id:Int)
//    case popular(page:Int)
//    case newMovies(page:Int)
//    case video(id:Int)
//        
//
////    var environmentBaseURL : String {
////        switch NetworkManager.environment {
////        case .production: return "https://api.themoviedb.org/3/movie/"
////        case .qa: return "https://qa.themoviedb.org/3/movie/"
////        case .staging: return "https://staging.themoviedb.org/3/movie/"
////        }
////    }
//    
//    var baseUrl: URL {
//        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else { fatalError("baseURL could not be configured.")}
//        return url
//    }
//    
//    var path: String {
//        switch self {
//        case .recommended(let id):
//            return "\(id)/recommendations"
//        case .popular:
//            return "popular"
//        case .newMovies:
//            return "now_playing"
//        case .video(let id):
//            return "\(id)/videos"
//        }
//    }
//    
//    var httpMethod: HTTPMethod {
//        return .GET
//    }
//    
//    var task: HTTPTask {
//        switch self {
//        case .newMovies(let page):
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: ["page":page,
//                                                      "api_key":apiKey])
//        default:
//            return .request
//        }
//    }
//    
//    var headers: HTTPHeaders? {
//        return nil
//    }
//}
