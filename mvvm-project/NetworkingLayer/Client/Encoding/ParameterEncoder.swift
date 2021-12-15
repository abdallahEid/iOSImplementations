//
//  ParameterEncoding.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import Foundation

protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest) throws
}
