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
    func fetchSearchArtistSort(sortType:SortType,searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ())

    
}

final class SearchService : SearchServiceInterface {
   
    
        
    static let shared = SearchService()
    func fetchAllService(completion: @escaping (Result<[AllService]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .allServices, responseClass: DataResult<AllService>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
    
    func fetchSearchArtist(searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .searchArtist(searchText), responseClass: DataResult<TopArtist>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }
    }
    
    func fetchSearchArtistFilterService(searchText: String,serviceId: Int, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .searhArtistFilter(searchText, serviceId),
                                    responseClass: DataResult<TopArtist>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
    
    func fetchSearchArtistSort(sortType:SortType,searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        print(sortType.toServiceType())
        print("Serice \(searchText)")
        NetworkManager.shared.fetch(target: .searhArtistSort(sortType.toServiceType(), searchText), responseClass: DataResult<TopArtist>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }
    }


 
    
    
}