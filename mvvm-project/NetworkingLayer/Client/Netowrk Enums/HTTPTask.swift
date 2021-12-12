//
//  HTTPTask.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

// MARK: - HTTPTask
enum HTTPTask {
    
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
    // You can add cases for downlaod, upload, ...
}
