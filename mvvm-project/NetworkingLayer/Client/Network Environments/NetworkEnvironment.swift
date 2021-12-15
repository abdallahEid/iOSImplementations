//
//  NetworkEnvironment.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import Foundation

// MARK: - NetworkEnvironment
enum NetworkEnvironment {
    case qa
    case production
    case staging
    
    // MARK: - Keys
    enum Keys {
      enum Plist {
          enum Configurations {
              static let baseUrl = "baseURL"
              static let apiKey = "apiKey"
          }
      }
    }

    // MARK: - Plist
    private static let configurationDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary, let configurations = dict["Configuration"] as? [String: Any] else {
        fatalError("Plist file not found")
      }
      return configurations
    }()

    // MARK: - Plist values
    static let baseUrl: URL = {
        guard let rootURLstring = NetworkEnvironment.configurationDictionary[Keys.Plist.Configurations.baseUrl] as? String else {
        fatalError("Root URL not set in plist for this environment")
      }
      guard let url = URL(string: rootURLstring) else {
        fatalError("Root URL is invalid")
      }
      return url
    }()

    static let apiKey: String = {
        guard let apiKey = NetworkEnvironment.configurationDictionary[Keys.Plist.Configurations.apiKey] as? String else {
        fatalError("API Key not set in plist for this environment")
      }
      return apiKey
    }()
}
