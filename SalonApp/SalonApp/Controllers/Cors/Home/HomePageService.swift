//
//  HomePageService.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation

protocol HomePageServiceInterface {
    var topServices : [TopService] {get}
    var topArtists : [TopArtist] {get}
    
    func fetchTopServices(completion:@escaping () -> ()) async
    func fetchTopArtists(completion:@escaping () -> ()) async
}


final class HomePageService :  HomePageServiceInterface{
    
    static let shared = HomePageService()
    
    var topServices = [TopService]()
    var topArtists =  [TopArtist]()
    
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
    
    func fetchTopArtists(completion: @escaping () -> ()) async {
        await NetworkManager.shared.fetch(target: .topArtists, responseClass: TopArtist.self) {[weak self] (response:Result<[TopArtist]?,Error>) in
                 switch response {
                 case .success(let list):
                     self?.topArtists = list!
                     completion()
                 case .failure(let error):
                     self?.topArtists = []
                     print("Error HomePage Service \(error.localizedDescription)")
                     completion()
                 }
             }
    }
}
