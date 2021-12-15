//
//  JSONDecoder.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 14/12/2021.
//

import Foundation

struct CodableDecoder<DecodableType: Decodable>: ResponseDecoder {
    
    func decode(responseData: Data) -> Result<Any, NetworkError> {
        do {
            let apiResponse = try JSONDecoder().decode(DecodableType.self, from: responseData)
            return .success(apiResponse)
        }catch {
            print(error)
            return .failure(.unableToDecode)
        }
        
    }
    
}
