//
//  MockArtistDetailSertvice.swift
//  SalonAppTests
//
//  Created by engin gülek on 28.08.2023.
//

import Foundation
@testable import SalonApp

final class MockArtistDetailService : ArtistDetailServiceInterfece {
    var mockFetchArtistDetailResult : Result<[ArtistDetail]?,Error>?
    
    var invokedFetchArtistDetail = false
    var invokedFetchArtistDetailCount = 0
    
    func fetchArtistDetail(artistId: Int, completion: @escaping (Result<[SalonApp.ArtistDetail]?, Error>) -> ()) {
        invokedFetchArtistDetail = true
        invokedFetchArtistDetailCount += 1
        if let result = mockFetchArtistDetailResult {
            completion(result)
        }
    }
    
    
}

