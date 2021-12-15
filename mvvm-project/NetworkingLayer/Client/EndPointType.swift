//
//  EndPointType.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import Foundation

protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryParameters: Parameters? { get }
    var bodyParameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    
    var encoder: ParameterEncoder { get }
    var decoder: ResponseDecoder { get }
}
