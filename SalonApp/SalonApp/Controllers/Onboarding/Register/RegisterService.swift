//
//  RegisterService.swift
//  SalonApp
//
//  Created by engin gülek on 11.09.2023.
//

import Foundation

protocol RegisterServiceProtocol {
    func registerUser(parameters:[String:Any],completion:@escaping(Result<SingInResult,Error>)->(()))
}


final class RegisterService: RegisterServiceProtocol {
    
    static let shared = RegisterService()
    
    func registerUser(parameters: [String : Any], completion: @escaping (Result<SingInResult, Error>) -> (())) {
        
        NetworkManager.shared.fetch(target: .createUser(parameters), responseClass: SingInResult.self) { response in
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
