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
    case topArtists
}

extension NetworkPath : TargetType {
    var baseURL: String {
        return "http://localhost:8080/api/"
    }
    
    var path: String {
        switch self {
        case .topServices:
            return "topServices/getAll"
            
        case .topArtists:
            return "artists/getTopArtists"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .topServices:
            return .get
        case .topArtists:
            return .get
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .topServices:
            return .requestPlain
        case .topArtists:
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

