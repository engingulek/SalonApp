//
//  NetworkUtils.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation
import Alamofire




enum NetworkPath  {
    case topArtists
    case artistDetail(Int)
    case artistComments(Int)
    case allServices
    case searchArtist(String)
    case searhArtistFilter(String,Int)
    case searhArtistSort(String,String)
    case bookMarkListId(Int)
    case addBookMarkList(Parameters)
    case deleteArtistFromBookMarkList(Int)
}

extension NetworkPath : TargetType {
    var baseURL: String {
        return "http://localhost:8080/api/"
    }
    
    var path: String {
        switch self {
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
        case .searhArtistSort(let sortType, let searchText):
            return "artists/getArtistSearchResultSort?sortType=\(sortType)&searchText=\(searchText)"
        case .bookMarkListId(let user_id):
            return "bookMarkList/bookMarkListId?user_id=\(user_id)"
        case .addBookMarkList:
            return "bookMarkList/add"
        case .deleteArtistFromBookMarkList(let id):
            return "bookMarkList/deleteArtistFromBookMarkList?id=\(id)"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .addBookMarkList:
            return .post
        case .deleteArtistFromBookMarkList:
            return .delete
        default:
            return .get
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .addBookMarkList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.init())
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

