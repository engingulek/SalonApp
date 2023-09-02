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
    case artistComments(Int)
    case allServices
    case searchArtist(String)
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
        case .artistComments(let artistId):
            return "artists/getArtistComment?artistId=\(artistId)"
        case .allServices:
            return "service/getAll"
        case .searchArtist(let searchText):
            return "artists/getArtistSearchResult?searchText=\(searchText)"
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
        case .artistComments:
            return .get
        case .allServices:
            return .get
        case .searchArtist:
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
        case .artistComments:
            return .requestPlain
        case .allServices:
            return .requestPlain
        case .searchArtist:
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

