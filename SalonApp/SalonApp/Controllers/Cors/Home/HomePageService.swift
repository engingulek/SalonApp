//
//  HomePageService.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation

protocol HomePageServiceInterface {
   /* var topServices : [TopService] {get}
    var topArtists : [TopArtist] {get}*/
    
    func fetchTopServices(completion:@escaping(Result<[TopService]?,Error> ) -> ())
    func fetchTopArtists(completion:@escaping(Result<[TopArtist]?,Error> ) -> ())
}


final class HomePageService :  HomePageServiceInterface{
    
    static let shared = HomePageService()    
    func fetchTopServices(completion: @escaping (Result<[TopService]?, Error>) -> Void) {
        NetworkManager.shared.fetch(target: .topServices, responseClass: TopService.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success!))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchTopArtists(completion:@escaping(Result<[TopArtist]?,Error> ) -> ())  {
        NetworkManager.shared.fetch(target: .topArtists, responseClass: TopArtist.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
