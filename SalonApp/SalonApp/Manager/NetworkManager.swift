//
//  NetworkManager.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation
import Alamofire
protocol NetworkManagerProtocol {
    var confing : NetworkConfig {get set}
    func fetch<T:Decodable>(url:NetworkPath,method:NetworkType,type:T.Type) async -> Result<T?,Error>
}

class NetworkManager : NetworkManagerProtocol {
    var confing: NetworkConfig
    init(confing:NetworkConfig){
        self.confing = confing
    }
    
    static let shared : NetworkManagerProtocol =  NetworkManager(confing: NetworkConfig(baseUrl: NetworkPath.baseURL))
    
    func fetch<T:Decodable>(url: NetworkPath, method: NetworkType, type: T.Type) async -> Result<T?, Error> {
        let request = AF.request("\(confing.baseUrl)/\(url.rawValue)",method: method.toAlamofire())
            .validate()
            .serializingDecodable(T.self)
        let result = await request.response
        guard let value = result.value else {
            return .failure(result.error ?? CustomError.networkError)
        }
        return .success(value)
    }
    
    
}
