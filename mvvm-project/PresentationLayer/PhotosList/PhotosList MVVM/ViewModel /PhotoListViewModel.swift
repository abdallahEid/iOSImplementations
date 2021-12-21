//
//  PhotoListViewModel.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import Foundation

class PhotoListViewModel {
    
    // MARK: - Properties
    private let listPhotosAPIManager: ListPhotoAPIManagerProtocol
    private var currentPage = 0
    private var users = [User]()
    
    var didFetchDataSuccessfully: ( ([PhotoInformationModel]) -> () )?
    var didFetchDataFailure: ( (NetworkError) -> () )?

    // MARK: - Initialization
    init(listPhotosAPIManager: ListPhotoAPIManagerProtocol) {
        self.listPhotosAPIManager = listPhotosAPIManager
    }
    
    // MARK: - Private Helpers
    private func getPhotosInformationModels() -> [PhotoInformationModel]{
        var models = [PhotoInformationModel]()
        
        for user in users {
            models.append(getPhotoInformationModel(from: user))
        }
        
        return models
    }
    
    private func handleDateForPhotoInformationModel(user: User) -> String{
        var dateToBeShown = "No Available Date"
       
        let inFormatter = DateFormatter()
        inFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let outFormatter = DateFormatter()
        outFormatter.dateFormat = "dd/MM/yy"
         
        if let dateStr = user.createdAt,
           let date = inFormatter.date(from: dateStr) {
            dateToBeShown = outFormatter.string(from: date)
        }
        
        return dateToBeShown
    }
    
    private func getPhotoInformationModel(from user: User) -> PhotoInformationModel{
        let dateString = handleDateForPhotoInformationModel(user: user)
        let description = user.instagramUsername ?? "Description here"
        let imageUrl = user.profileImage.large
        let name = user.name
        
        let model = PhotoInformationModel(
            imageUrl: imageUrl ,
            description: description,
            name: name,
            date: dateString
        )
        
        return model
    }
    
    // MARK: - Fetch Photos
    func fetchPhotos(){
        currentPage += 1
        
        Task.init {
            do {
                let response = try await  listPhotosAPIManager.getPhotosListAsyncWait(page: currentPage)
                self.users = response.map( { $0.user } )
                let models = getPhotosInformationModels()
                didFetchDataSuccessfully?(models)
            } catch let e as NetworkError{
                didFetchDataFailure?(e)
            }
        }
        
        
//        listPhotosAPIManager.getPhotosList(page: currentPage) { [weak self] apiResponses, error in
//            guard let weakSelf = self, let apiResponses = apiResponses else {
//                return
//            }
//
//            for apiResponse in apiResponses {
//                var response = apiResponse
//                response.user.createdAt = response.createdAt
//                weakSelf.users.append(response.user)
//            }
//
//            let models = weakSelf.getPhotosInformationModels()
//            weakSelf.didFetchData?(models)
//        }
    }
    
    // MARK: - Internal Helpers
    var usersCount: Int {
        return users.count
    }
    
    func isUserAvailableToHire(index: Int) -> Bool{
        return users[index].forHire
    }
    
    func getImageForUser(index: Int) -> String{
        return users[index].profileImage.large
    }
    
    func getPhotoInformationModel(index: Int) -> PhotoInformationModel{
        return getPhotoInformationModel(from: users[index])
    }
}
