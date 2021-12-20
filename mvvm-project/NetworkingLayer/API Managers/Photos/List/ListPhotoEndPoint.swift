//
//  ListPhotoEndPoint.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import Foundation

struct ListPhotoEndPoint: EndPointType {
    var baseUrl: URL {
        return NetworkEnvironment.baseUrl
    }
    
    var path: String {
        return "photos"
    }
    
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var queryParameters: Parameters?
    
    var bodyParameters: Parameters?
    
    var headers: HTTPHeaders? {
        return [
            "Authorization": "Client-ID \(NetworkEnvironment.apiKey)"
        ]
    }
    
    var encoder: ParameterEncoder {
        return URLParameterEncoder(parameters: queryParameters ?? [:])
    }
    
    var decoder: ResponseDecoder {
        return CodableDecoder<[PhotosListResponse]>()
    }
    
    
}
