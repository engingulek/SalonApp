//
//  LoginService.swift
//  SalonApp
//
//  Created by engin gülek on 11.09.2023.
//

import Foundation

protocol LoginServiceInterface {
    func loginUser(parameters:[String:Any],completion:@escaping(Result<SingInResult,Error>)->(()))
}

final class LoginService : LoginServiceInterface{
    static let shared = LoginService()
    
    func loginUser(parameters: [String : Any], completion: @escaping (Result<SingInResult, Error>) -> (())) {
        NetworkManager.shared.fetch(target: .singIn(parameters), responseClass: SingInResult.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success!))
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(failure))
            }
            
        }
    }
}
