//
//  ProfileServiceManager.swift
//  SalonApp
//
//  Created by engin gülek on 13.09.2023.
//

import Foundation

protocol ProfileServiceInterdace {
    func updateProfile(parameters:[String:Any],completion:@escaping(Result<SingInResult,Error>)->(()))
}


final class ProfileService : ProfileServiceInterdace {
    
    
    static let shared = ProfileService()
    
    func updateProfile(parameters: [String : Any], completion: @escaping (Result<SingInResult, Error>) -> (())) {
        NetworkManager.shared.fetch(target: .userUpdate(parameters), responseClass: SingInResult.self) { response in
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
