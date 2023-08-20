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

enum NetworkPath : String {
    case topServices
}

extension NetworkPath : TargetType {
    var baseURL: String {
        return "http://localhost:8080/api/"
    }
    
    var path: String {
        switch self {
        case .topServices:
            return "topServices/getAll"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .topServices:
            return .get
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .topServices:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
           switch self {
           default:
               return [:]
           }
       }
    
    
}





struct ProductConstants {
    static let BASE_URL = "http://localhost:8080/api/"
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
