//
//  ListPhotoAPIManager.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import Foundation

protocol ListPhotoAPIManagerProtocol {
    func getPhotosList(page: Int, completion: @escaping ([PhotosListResponse]?, NetworkError?) -> ())
}

struct ListPhotoAPIManager: ListPhotoAPIManagerProtocol {
    func getPhotosList(page: Int, completion: @escaping ([PhotosListResponse]?, NetworkError?) -> ()) {
        
        var endPoint = ListPhotoEndPoint()
        endPoint.queryParameters = [
            "page": page
        ]
        
        NetworkRouter().request(endPoint) { result in
            switch result {
            case .success(let data):
                let decodeResult = endPoint.decoder.decode(responseData: data)
                switch decodeResult {
                case .success(let apiResponse):
                    if let response = apiResponse as? [PhotosListResponse] {
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
