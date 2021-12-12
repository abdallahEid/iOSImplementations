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
    
    // MARK: - Protocol Functions
    func request<decodableType: Decodable>(_ route: EndPointType, completion: @escaping (_ result: Result<decodableType, NetworkError>)->()) {
        
        if !Reachability.isConnectedToNetwork {
            completion(.failure(.noInternet))
            return
        }
        
        do {
            let request = try self.buildRequest(from: route)
            task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                
                if error != nil {
                    completion(.failure(.noInternet))
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(.noData))
                            return
                        }
                        do {
//                            print(responseData)
//                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(decodableType.self, from: responseData)
                            completion(.success(apiResponse))
                        }catch {
                            print(error)
                            completion(.failure(.unableToDecode))
                        }
                    case .failure(let networkFailureError):
                        completion(.failure(networkFailureError))

                    }
                }
                
            })
        }catch {
            if let error = error as? NetworkError {
                completion(.failure(error))
            } else {
                completion(.failure(NetworkError.failed))
            }
        }
       
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Helpers
    private func buildRequest(from route: EndPointType) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        addHeaders(basicHeaders, request: &request)
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
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
