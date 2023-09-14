//
//  MockBookMarkListService.swift
//  SalonAppTests
//
//  Created by engin gülek on 14.09.2023.
//

import Foundation
@testable import SalonApp

final class MockBookMarkListService : BookMarkListServiceInterface {
    
    var mockFetchBookMarkList : Result<[SalonApp.BookMarkListArtist]?,Error>?
    var mockDeleteArtistToBookMarkList : Result<MessageResult,Error>?
                                        
                                        
    
    func fetchBookMarkList(userId: Int, completion: @escaping (Result<[SalonApp.BookMarkListArtist]?, Error>) -> ()) {
        if let result = mockFetchBookMarkList {
            completion(result)
        }
        
    }
    
    func deleteArtistToBookMarkList(id: Int, completion: @escaping (Result<SalonApp.MessageResult, Error>) -> ()) {
        if let result = mockDeleteArtistToBookMarkList {
            completion(result)
        }
        
    }
    
    
}
