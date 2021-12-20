//
//  PhotoListViewModelTests.swift
//  mvvm-projectTests
//
//  Created by Abdallah Eid on 20/12/2021.
//

import XCTest
@testable import mvvm_project

class PhotoListViewModelTests: XCTestCase {

    // MARK: - Properties
    private var sut: PhotoListViewModel!
    private var photoListAPIManager: MockListPhotosAPIManager!
    
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Response 1
    private var dummyPhotosResponse1: PhotosListResponse {
        return PhotosListResponse(
            user: dummyUser1,
            createdAt: "2021-12-20T16:24:42-05:00"
        )
    }
    
    private var dummyUser1: User {
        return User(
            twitterUsername: "twitterUsername1",
            instagramUsername: "instagramUsername1",
            username: "username1",
            profileImage: profileImage1,
            name: "name1",
            createdAt: "20/12/21",
            forHire: true
        )
    }
    
    private var profileImage1: ProfileImage {
        return ProfileImage(small: "small1", large: "large1", medium: "medium1")
    }
    
    // MARK: - Response 2
    private var dummyPhotosResponse2: PhotosListResponse {
        return PhotosListResponse(
            user: dummyUser2,
            createdAt: "createdAt2"
        )
    }
    
    private var dummyUser2: User {
        return User(
            twitterUsername: "twitterUsername2",
            instagramUsername: "instagramUsername2",
            username: "username2",
            profileImage: profileImage2,
            name: "name2",
            createdAt: "createdAt2",
            forHire: false
        )
    }
    
    private var profileImage2: ProfileImage {
        return ProfileImage(small: "small2", large: "large2", medium: "medium2")
    }
    
    // MARK: - Response 3
    private var dummyPhotosResponse3: PhotosListResponse {
        return PhotosListResponse(
            user: dummyUser3,
            createdAt: "createdAt3"
        )
    }
    
    private var dummyUser3: User {
        return User(
            twitterUsername: "twitterUsername3",
            instagramUsername: "instagramUsername3",
            username: "username3",
            profileImage: profileImage3,
            name: "name3",
            createdAt: "createdAt3",
            forHire: true
        )
    }
    
    private var profileImage3: ProfileImage {
        return ProfileImage(small: "small3", large: "large3", medium: "medium3")
    }
    
    private var responseArray: [PhotosListResponse] {
        return [
            dummyPhotosResponse1,
            dummyPhotosResponse2,
            dummyPhotosResponse3
        ]
    }
}

extension PhotoListViewModelTests {
    func test_fetchPhotos_callAPI_success() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        
        // Act
        sut.fetchPhotos()
        
        // Assert
        XCTAssertEqual(sut.usersCount, responseArray.count)

    }
    
    func test_fetchPhotos_callAPI_failure() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = nil
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        
        // Act
        sut.fetchPhotos()
        
        // Assert
        XCTAssertEqual(sut.usersCount, 0)
    }
    
    func test_isUserAvialableToHire_userAvailable_success() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        let index = 2 // dummyUser3
        
        // Act
        sut.fetchPhotos()
        let isUserAvailableToHire = sut.isUserAvailableToHire(index: index)
        
        // Assert
        XCTAssertEqual(isUserAvailableToHire, responseArray[index].user.forHire)
    }
    
    func test_isUserAvialableToHire_userAvailable_failure() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        let index = 2 // dummyUser3
        
        // Act
        sut.fetchPhotos()
        let isUserAvailableToHire = sut.isUserAvailableToHire(index: index)
        
        // Assert
        XCTAssertNotEqual(isUserAvailableToHire, !responseArray[index].user.forHire)
    }
    
    func test_isUserAvialableToHire_userNotAvailable_success() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        let index = 1 // dummyUser2
        
        // Act
        sut.fetchPhotos()
        let isUserAvailableToHire = sut.isUserAvailableToHire(index: index)
        
        // Assert
        XCTAssertEqual(isUserAvailableToHire, responseArray[index].user.forHire)
    }
    
    func test_isUserAvialableToHire_userNotAvailable_failure() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        let index = 1 // dummyUser2
        
        // Act
        sut.fetchPhotos()
        let isUserAvailableToHire = sut.isUserAvailableToHire(index: index)
        
        // Assert
        XCTAssertNotEqual(isUserAvailableToHire, !responseArray[index].user.forHire)
    }
    
    func test_getImageForUser_success() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        let index = 0 // dummyUser1
        
        // Act
        sut.fetchPhotos()
        let image = sut.getImageForUser(index: index)
        
        // Assert
        XCTAssertEqual(image, responseArray[index].user.profileImage.large)
    }
    
    func test_getImageForUser_failure() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        let index = 0 // dummyUser1
        let anotherIndex = 1
        
        // Act
        sut.fetchPhotos()
        let image = sut.getImageForUser(index: index)

        // Assert
        XCTAssertNotEqual(image, responseArray[anotherIndex].user.profileImage.large)

    }
    
    func test_getPhotoInformationModel_success() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        let index = 0 // dummyUser1
        let photoModel = PhotoInformationModel(imageUrl: dummyPhotosResponse1.user.profileImage.large, description: dummyPhotosResponse1.user.instagramUsername!, name: dummyPhotosResponse1.user.name, date: dummyPhotosResponse1.user.createdAt!)
        
        // Act
        sut.fetchPhotos()
        let model = sut.getPhotoInformationModel(index: index)

        // Assert
        XCTAssertEqual(model, photoModel)
    }
    
    func test_getPhotoInformationModel_failure() {
        // Arrange
        photoListAPIManager = MockListPhotosAPIManager()
        photoListAPIManager.getPhotosListResult = responseArray
        sut = PhotoListViewModel(listPhotosAPIManager: photoListAPIManager)
        let index = 1 // dummyUser1
        let photoModel = PhotoInformationModel(imageUrl: dummyPhotosResponse2.user.profileImage.large, description: dummyPhotosResponse2.user.instagramUsername!, name: dummyPhotosResponse2.user.name, date: dummyPhotosResponse2.user.createdAt!)
        
        // Act
        sut.fetchPhotos()
        let model = sut.getPhotoInformationModel(index: index)

        // Assert
        XCTAssertNotEqual(model, photoModel)
    }
}
