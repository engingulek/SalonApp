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
    
    /// Update User
    /// - Parameters:
    ///   - parameters: Update user info
    ///   - completion: user information or error message returned as a result of the operation
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
