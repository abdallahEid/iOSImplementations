//
//  PopularMoviesEndPoint.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import Foundation

struct PopularMoviesEndPoint: EndPointType {
    
    // MARK: - Properties
    var baseUrl: URL {
        return NetworkEnvironment.baseUrl
    }
    
    var path: String {
        return "movie/popular"
    }
    
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var bodyParameters: Parameters? {
        return nil
    }
    
    var queryParameters: Parameters? {
        return [
            "api_key":NetworkEnvironment.apiKey
        ]
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var encoder: ParameterEncoder {
        return URLParameterEncoder(parameters: queryParameters ?? [:])
    }
    
    var decoder: ResponseDecoder {
        return MappableDecoder<MovieApiResponse>()
//        return CodableDecoder<MovieApiResponse>()
    }
}
