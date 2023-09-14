//
//  SearchService.swift
//  SalonApp
//
//  Created by engin gülek on 2.09.2023.
//

import Foundation

protocol SearchServiceInterface {
    func fetchAllService(completion:@escaping(Result<[Service]?,Error> ) -> ())
    func fetchSearchArtist(searchText:String,completion:@escaping(Result<[Artist]?,Error> ) -> ())
    func fetchSearchArtistFilterService(searchText:String,serviceId:Int,completion:@escaping(Result<[Artist]?,Error> ) -> ())
    func fetchSearchArtistSort(sortType:SortType,searchText: String, completion: @escaping (Result<[Artist]?, Error>) -> ())

    
}

final class SearchService : SearchServiceInterface {
   
    
        
    static let shared = SearchService()
    
    //MARK: Fetch All Service
    func fetchAllService(completion: @escaping (Result<[Service]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .allServices, responseClass: DataResult<Service>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
    
    //MARK: Artist search will take place
    func fetchSearchArtist(searchText: String, completion: @escaping (Result<[Artist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .searchArtist(searchText), responseClass: DataResult<Artist>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }
    }
    //MARK: Fetch Search Artist Filter Service
    // Artist search will be carried out with the service.
    func fetchSearchArtistFilterService(searchText: String,serviceId: Int, completion: @escaping (Result<[Artist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .searhArtistFilter(searchText, serviceId),
                                    responseClass: DataResult<Artist>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
    //MARK: fetch Search Artist Sort
    /// Artist glazing will take place
    func fetchSearchArtistSort(sortType:SortType,searchText: String, completion: @escaping (Result<[Artist]?, Error>) -> ()) {
        print(sortType.toServiceType())
        print("Serice \(searchText)")
        NetworkManager.shared.fetch(target: .searhArtistSort(sortType.toServiceType(), searchText), responseClass: DataResult<Artist>.self) { response in
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
