//
//  SearchService.swift
//  SalonApp
//
//  Created by engin gülek on 2.09.2023.
//

import Foundation

protocol SearchServiceInterface {
    func fetchAllService(completion:@escaping(Result<[AllService]?,Error> ) -> ())
    func fetchSearchArtist(searchText:String,completion:@escaping(Result<[TopArtist]?,Error> ) -> ())
    func fetchSearchArtistFilterService(searchText:String,serviceId:Int,completion:@escaping(Result<[TopArtist]?,Error> ) -> ())
    func fetchSearchArtistPayDesc(searchText:String,completion:@escaping(Result<[TopArtist]?,Error> ) -> ())
    func fetchSearchArtistPayAsc(searchText:String,completion:@escaping(Result<[TopArtist]?,Error> ) -> ())
    func fetchSearchArtistHightRating(searchText:String,completion:@escaping(Result<[TopArtist]?,Error> ) -> ())
}

final class SearchService : SearchServiceInterface {
    static let shared = SearchService()
    func fetchAllService(completion: @escaping (Result<[AllService]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .allServices, responseClass: AllService.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
    
    func fetchSearchArtist(searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .searchArtist(searchText), responseClass: TopArtist.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }
    }
    
    func fetchSearchArtistFilterService(searchText: String,serviceId: Int, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .searhArtistFilter(searchText, serviceId),
                                    responseClass: TopArtist.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
    
    func fetchSearchArtistPayDesc(searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .payDesc(searchText), responseClass: TopArtist.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }

    }
    
    func fetchSearchArtistPayAsc(searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .payAsc(searchText), responseClass: TopArtist.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }

    }
    
    func fetchSearchArtistHightRating(searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .hightRating(searchText), responseClass: TopArtist.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }

    }
    
    
    
}
