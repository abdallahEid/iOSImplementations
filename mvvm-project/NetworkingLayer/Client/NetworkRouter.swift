//
//  NetworkRouter.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import Foundation

typealias Parameters = [String:Any]
typealias HTTPHeaders = [String:String]

class Router {
    
    // MARK: - Properties
    private var task: URLSessionTask?
    private var basicHeaders: HTTPHeaders {
        let headers = HTTPHeaders()
        return headers
    }
    
    func request(_ route: EndPointType, completion: @escaping ( _ result: Result<Data, NetworkError>) -> () ) {
        
        if !Reachability.isConnectedToNetwork {
            completion(.failure(NetworkError.noInternet))
            return
        }

        // Request with base url & path
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        // httpMethod
        request.httpMethod = route.httpMethod.rawValue
        
        // Headers
        addHeaders(basicHeaders, request: &request)
        addHeaders(route.headers ?? [:], request: &request)
        
        // encoding
        do {
            try route.encoder.encode(urlRequest: &request)
        } catch {
            completion(.failure(NetworkError.encodingFailed))
        }

        // Making the request
        task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.noData))
            }
        })
       
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Helpers
    
    private func addHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<(), NetworkError>{
        switch response.statusCode {
            case 200...299: return .success(())
            case 401...500: return .failure(NetworkError.authenticationError)
            case 501...599: return .failure(NetworkError.badRequest)
            case 600: return .failure(NetworkError.outdated)
            default: return .failure(NetworkError.failed)
        }
    }
}
