//
//  HomePageService.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation

protocol HomePageServiceInterface {
    func fetchTopArtists(completion:@escaping(Result<[TopArtist]?,Error> ) -> ())
   
    /*func fetchAddArtistToBookMarkList(userId:Int,artistId:Int)
    func deleteArtistFromBookMarkList(id:Int)*/
}


final class HomePageService :  HomePageServiceInterface{
    static let shared = HomePageService()        
    func fetchTopArtists(completion:@escaping(Result<[TopArtist]?,Error> ) -> ())  {
        NetworkManager.shared.fetch(target: .topArtists, responseClass: TopArtist.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
             
            }
        }
    }
    
   /* func fetchbookMarkListId(userId:Int,completion: @escaping (Result<[BookMarkList]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .bookMarkListId(userId),
                                    responseClass: BookMarkList.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }
    }
    
    func fetchAddArtistToBookMarkList(userId:Int,artistId:Int){
        let params  = ["user_id" : userId, "artist_id" : artistId]
        NetworkManager.shared.fetch(target: .addBookMarkList(params), responseClass: AddDataResult.self) { response in
            switch response {
            case .success(let success):
                print(success![0])
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func deleteArtistFromBookMarkList(id:Int){
        NetworkManager.shared.fetch(target: .deleteArtistFromBookMarkList(id), responseClass: AddDataResult.self) { response in
            switch response {
            case .success(let success):
                print(success![0])
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }*/
}
