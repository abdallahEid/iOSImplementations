//
//  Photo.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 18/12/2021.
//

import Foundation

struct PhotosListResponse: Codable {

    var user: User
    var createdAt: String

    enum CodingKeys: String, CodingKey {
        case user
        case createdAt = "created_at"
    }
}

// MARK: - User
struct User: Codable {
    let twitterUsername, instagramUsername: String?
    let username: String
    let profileImage: ProfileImage
    let name: String
    var createdAt: String?
    let forHire: Bool

    enum CodingKeys: String, CodingKey {

        case twitterUsername = "twitter_username"
        case instagramUsername = "instagram_username"
        case username
        case profileImage = "profile_image"
        case name
        case forHire = "for_hire"
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, large, medium: String
}
