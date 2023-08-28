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

enum NetworkPath  {
    case topServices
    case topArtists
    case artistDetail(Int)
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
        case .artistDetail(let artistId):
            return "artists/getArtistInfo?artistId=\(artistId)"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .topServices:
            return .get
        case .topArtists:
            return .get
        case .artistDetail:
            return .get
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .topServices:
            return .requestPlain
        case .topArtists:
            return .requestPlain
        case .artistDetail:
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

