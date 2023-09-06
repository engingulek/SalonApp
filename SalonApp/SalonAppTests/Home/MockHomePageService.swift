//
//  MockHomePageService.swift
//  SalonAppTests
//
//  Created by engin gülek on 21.08.2023.
//

import Foundation
@testable import SalonApp

final class MockHomePageService : HomePageServiceInterface {
    var mockFetchTopServices : Result<[TopService]?, Error>?
    var mockFetchTopArtist : Result<[TopArtist]?, Error>?
    
    func fetchTopServices(completion: @escaping (Result<[SalonApp.TopService]?, Error>) -> ())  {
        if let result = mockFetchTopServices {
            completion(result)
        }
    }
    
    func fetchTopArtists(completion: @escaping (Result<[SalonApp.TopArtist]?, Error>) -> ())  {
        if let result = mockFetchTopArtist {
            completion(result)
        }
    }

}

 
