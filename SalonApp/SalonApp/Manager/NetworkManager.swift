//
//  NetworkManager.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation
import Alamofire
protocol NetworkManagerProtocol {
    func fetch<T : Codable>(target:NetworkPath,responseClass:T.Type,completion:@escaping(Result<[T]?,Error>)->()) async
   
}

class NetworkManager : NetworkManagerProtocol {

    static let shared = NetworkManager()
    
    func fetch<T : Decodable>(target:NetworkPath,responseClass:T.Type,completion:@escaping(Result<[T]?,Error>)->()) async{
            let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
            let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
            let parameters = buildParams(requestType: target.requestType)
            AF.request(target.baseURL + target.path,method: method,parameters: parameters.0,encoding: parameters.1,headers: headers).response{
                (response) in

                if let data = response.data{
                    do{
                        let result = try JSONDecoder().decode(DataResult<T>.self, from: data)
                        completion(.success(result.data))
                    }catch{
                        DispatchQueue.main.async {
                            completion(.failure(error))
                            print("Data Error \(error.localizedDescription)")
                        }
                    }
                }
            }
        }

    private func buildParams(requestType: RequestType) -> ([String: Any], ParameterEncoding) {
         
         switch requestType {
             
         case .requestPlain:
             return ([:], URLEncoding.default)
         case .requestParameters(parameters: let parameters, encoding: let encoding):
             return (parameters, encoding)
         }
     }
    
}
