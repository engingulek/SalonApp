//
//  MockHomePageService.swift
//  SalonAppTests
//
//  Created by engin gülek on 21.08.2023.
//

import Foundation
@testable import SalonApp

final class MockHomePageService : HomePageServiceInterface {
    
    
    var mockFetchTopArtist : Result<[Artist]?, Error>?
    var mockFetchBookMarkList : Result<[BookMarkListArtist]?,Error>?
    var mockMessageResult : Result<MessageResult, Error>?
    
    func fetchTopArtists(completion: @escaping (Result<[SalonApp.Artist]?, Error>) -> ())  {
        if let result = mockFetchTopArtist {
            completion(result)
        }
    }
    
    func fetchBookMarkList(userId: Int, completion: @escaping (Result<[SalonApp.BookMarkListArtist]?, Error>) -> ()) {
        if let result = mockFetchBookMarkList{
            completion(result)
        }
        
    }
    
    func addArtistToBookMarkList(parameters: [String : Any], completion: @escaping (Result<SalonApp.MessageResult, Error>) -> ()) {
        if let result = mockMessageResult {
            completion(result)
        }
    }
    
    func deleteArtistToBookMarkList(id: Int, completion: @escaping (Result<SalonApp.MessageResult, Error>) -> ()) {
        if let result = mockMessageResult {
            completion(result)
        }
    }

}

 
