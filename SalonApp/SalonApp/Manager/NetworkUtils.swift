//
//  NetworkUtils.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation
import Alamofire

enum CustomError: Error {
    case networkError
}


struct ProductConstants {
    static let BASE_URL = "http://localhost:8080/api/"
}

enum NetworkPath : String {
    case topServices = "topServices/getAll"
    static let baseURL = ProductConstants.BASE_URL
}

enum NetworkType {
    case get
    func toAlamofire() -> HTTPMethod {
        switch self{
        case .get:
            return .get
        }
    }
}
