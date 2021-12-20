//
//  MockListPhotosAPIManager.swift
//  mvvm-projectTests
//
//  Created by Abdallah Eid on 20/12/2021.
//

import Foundation
@testable import mvvm_project

class MockListPhotosAPIManager: ListPhotoAPIManagerProtocol {
    
    var getPhotosListResult: [PhotosListResponse]?
    
    func getPhotosList(page: Int, completion: @escaping ([PhotosListResponse]?, NetworkError?) -> ()) {
        
        if let getPhotosListResult = getPhotosListResult {
            completion(getPhotosListResult, nil)
        } else {
            completion(nil, NetworkError.failed )
        }
        
    }
}
