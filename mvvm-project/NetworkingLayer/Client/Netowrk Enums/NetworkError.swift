//
//  NetworkError.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

// MARK: - NetworkError
enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case noInternet = "Please check your network connection."
}
