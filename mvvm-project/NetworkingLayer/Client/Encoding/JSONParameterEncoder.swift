//
//  JSONParameterEncoder.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    
    let parameters: Parameters
    
    init(parameters: Parameters) {
        self.parameters = parameters
    }
    
    func encode(urlRequest: inout URLRequest) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
