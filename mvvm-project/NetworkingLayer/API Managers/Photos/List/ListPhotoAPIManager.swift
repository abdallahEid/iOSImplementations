//
//  ListPhotoAPIManager.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import Foundation

protocol ListPhotoAPIManagerProtocol {
    func getPhotosList(page: Int, completion: @escaping ([PhotosListResponse]?, NetworkError?) -> ())
    func getPhotosListAsyncWait(page: Int) async throws -> [PhotosListResponse]
}

struct ListPhotoAPIManager: ListPhotoAPIManagerProtocol {
    func getPhotosListAsyncWait(page: Int) async throws -> [PhotosListResponse] {
        var endPoint = ListPhotoEndPoint()
        endPoint.queryParameters = [
            "page": page
        ]
        
        do {
            let data = try await NetworkRouter().requestAsync(endPoint)
            let decodeResult = endPoint.decoder.decode(responseData: data)
            switch decodeResult {
            case .success(let apiResponse):
                guard let response = apiResponse as? [PhotosListResponse] else {
                    throw NetworkError.unableToDecode
                }
                return response
            case .failure(let _):
                throw NetworkError.unableToDecode
            }
        } catch {
            throw NetworkError.unableToDecode
        }
    }
    
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
