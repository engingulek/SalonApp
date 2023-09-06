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
    case searhArtistFilter(String,Int)
    case payDesc(String)
    case payAsc(String)
    case hightRating(String)
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
        case .searhArtistFilter(let searchText, let serviceId):
            return "artists/getArtistSearchResultFilterService?searchText=\(searchText)&serviceId=\(serviceId)"
        case .payDesc(let searchText):
            return "artists/getArtistSearchResultOrderPayDESC?searchText=\(searchText)"
        case .payAsc(let searchText):
            return "artists/getArtistSearchResultOrderPayASC?searchText=\(searchText)"
        case .hightRating(let searchText):
            return "artists/getArtistSearchResultHighRating?searchText=\(searchText)"
     
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var requestType: RequestType {
        switch self {
        default:
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

