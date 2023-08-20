//
//  RequestType.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation
import Alamofire

enum AlamofireMethod: String {
    case get = "GET"
}


enum RequestType {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol TargetType {
    
    var baseURL: String {get}
    
    var path: String {get}
    
    var method: AlamofireMethod {get}
    
    var requestType: RequestType {get}
    
    var headers: [String: String]? {get}
}
