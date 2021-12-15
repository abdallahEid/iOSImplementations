//
//  MappableDecoder.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 15/12/2021.
//

import Foundation
import ObjectMapper

struct MappableDecoder<DecodableType: Mappable>: ResponseDecoder {
    
    func decode(responseData: Data) -> Result<Any, NetworkError> {
        do {

            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
            let apiResponse = Mapper<DecodableType>().map(JSONObject: json)
            
            if let apiResponse = apiResponse {
                return .success(apiResponse)
            } else {
                return .failure(.unableToDecode)
            }
            
        }catch {
            print(error)
            return .failure(.unableToDecode)
        }
        
    }
    
}
