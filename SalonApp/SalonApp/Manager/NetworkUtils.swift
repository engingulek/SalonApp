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
    case addArtistToBookMarkList(Parameters)
    case bookMarkListArtist(Int)
    case deleteArtistFromBookMarkList(Int)
    case createUser(Parameters)
    case singIn(Parameters)
    case userUpdate(Parameters)
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
        case .bookMarkListArtist(let user_id):
            return "bookMarkList/bookMarkListData?user_id=\(user_id)"
        case .deleteArtistFromBookMarkList(let id):
            return "bookMarkList/deleteArtistFromBookMarkList?id=\(id)"
        case .addArtistToBookMarkList:
            return "bookMarkList/add"
        case .createUser:
            return "users/userCreate"
        case .singIn:
            return "users/singIn"
        case .userUpdate:
            return "users/userUpdate"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .addArtistToBookMarkList:
            return .post
        case .createUser:
            return .post
        case .singIn:
            return .post
        case .userUpdate:
            return .post
        case .deleteArtistFromBookMarkList:
            return .delete
        default:
            return .get
        }
    }
    
 
    
    var requestType: RequestType {
        switch self {
        case .addArtistToBookMarkList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.init())
        case .createUser(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.init())
        case .singIn(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.init())
        case .userUpdate(let parameters):
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

