//
//  BookMarkListService.swift
//  SalonApp
//
//  Created by engin gülek on 8.09.2023.
//

import Foundation

protocol BookMarkListServiceInterface {
    func fetchBookMarkList(userId:Int,completion:@escaping(Result<[BookMarkListArtist]?,Error> ) -> ())
    func deleteArtistFromBookMarkList(id:Int)
}

final class BookMarkListService : BookMarkListServiceInterface  {
    static let shared = BookMarkListService()
    func fetchBookMarkList(userId: Int, completion: @escaping (Result<[BookMarkListArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .bookMarkListArtist(userId), responseClass: BookMarkListArtist.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
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
     }
    
    
}
