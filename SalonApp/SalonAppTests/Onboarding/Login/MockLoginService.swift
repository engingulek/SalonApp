//
//  MockLoginService.swift
//  SalonAppTests
//
//  Created by engin gülek on 14.09.2023.
//

import Foundation
@testable import SalonApp
import UIKit.UIViewController

final class MockLoginService : LoginServiceInterface {
    var mockLoginUser : Result<SingInResult,Error>?
    func loginUser(parameters: [String : Any], completion: @escaping (Result<SalonApp.SingInResult, Error>) -> (())) {
        if let result = mockLoginUser {
            completion(result)
        }
    }
    
  
    
    
}
