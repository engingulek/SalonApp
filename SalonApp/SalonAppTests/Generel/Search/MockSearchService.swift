//
//  MockSearchService.swift
//  SalonAppTests
//
//  Created by engin gülek on 6.09.2023.
//

import Foundation
@testable import SalonApp

final class MockSearchService : SearchServiceInterface {
    var mockFetchAllServices : Result<[Service]?, Error>?
    var mockFetchsearchArtist : Result<[Artist]?, Error>?
    var fetchAllServiceDataCalled = false
    var fetchSearchArtistCalled = false
    func fetchAllService(completion: @escaping (Result<[Service]?, Error>) -> ()) {
        fetchAllServiceDataCalled = true
        if let result = mockFetchAllServices {
            
            completion(result)
        }
    }
    
    func fetchSearchArtist(searchText: String, completion: @escaping (Result<[Artist]?, Error>) -> ()) {
        fetchSearchArtistCalled = true
        if let result =  mockFetchsearchArtist {
            completion(result)
        }
        
    }
    
    func fetchSearchArtistFilterService(searchText: String, serviceId: Int, completion: @escaping (Result<[Artist]?, Error>) -> ()) {
        if let result =  mockFetchsearchArtist {
            completion(result)
        }
        
        
    }
    
    func fetchSearchArtistSort(sortType:SortType, searchText: String, completion: @escaping (Result<[Artist]?, Error>) -> ()) {
        if let result =  mockFetchsearchArtist {
            completion(result)
        }
        
        
    }
    
    
}
