//
//  MockHomePageService.swift
//  SalonAppTests
//
//  Created by engin gülek on 21.08.2023.
//

import Foundation
@testable import SalonApp
final class MockHomePageService : HomePageServiceInterface {
    var topServices: [SalonApp.TopService] = []
    var invokedFetchTopService = false
    var invokedFetchTopServiceCount = 0
    
    func fetchTopServices(completion: @escaping () -> ()) async {
        invokedFetchTopService = true
        invokedFetchTopServiceCount += 1
        completion()
    }
    
    
}
 
