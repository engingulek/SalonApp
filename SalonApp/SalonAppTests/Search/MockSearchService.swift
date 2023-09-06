//
//  MockSearchService.swift
//  SalonAppTests
//
//  Created by engin gülek on 6.09.2023.
//

import Foundation
@testable import SalonApp

final class MockSearchService : SearchServiceInterface {
    var mockFetchAllServices : Result<[AllService]?, Error>?
    var mockFetchsearchArtist : Result<[TopArtist]?, Error>?
    var fetchAllServiceDataCalled = false
    var fetchSearchArtistCalled = false
    func fetchAllService(completion: @escaping (Result<[AllService]?, Error>) -> ()) {
        fetchAllServiceDataCalled = true
        if let result = mockFetchAllServices {
            
            completion(result)
        }
    }
    
    func fetchSearchArtist(searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        fetchSearchArtistCalled = true
        if let result =  mockFetchsearchArtist {
            completion(result)
        }
        
    }
    
    func fetchSearchArtistFilterService(searchText: String, serviceId: Int, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        if let result =  mockFetchsearchArtist {
            completion(result)
        }
        
        
    }
    
    func fetchSearchArtistSort(sortType:SortType, searchText: String, completion: @escaping (Result<[TopArtist]?, Error>) -> ()) {
        if let result =  mockFetchsearchArtist {
            completion(result)
        }
        
        
    }
    
    
}
