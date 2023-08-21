//
//  HomePageService.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation

protocol HomePageServiceInterface {
    var topServices : [TopService] {get}
    
    func fetchTopServices(completion:@escaping () -> ()) async
}


final class HomePageService :  HomePageServiceInterface{
    static let shared = HomePageService()
    var topServices = [TopService]()
    
    func fetchTopServices(completion:@escaping () -> ()) async {
        await NetworkManager.shared.fetch(target: .topServices, responseClass: TopService.self) {[weak self] (response:Result<[TopService]?,Error>) in
                 switch response {
                 case .success(let list):
                     self?.topServices = list!
                     completion()
                 case .failure(let error):
                     self?.topServices = []
                     print("Error HomePage Service \(error.localizedDescription)")
                     completion()
                 }
             }
    }
}
