//
//  ResponseDecoder.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 14/12/2021.
//

import Foundation

protocol ResponseDecoder {
    func decode(responseData: Data) -> Result<Any, NetworkError>
}
