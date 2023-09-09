//
//  BookMarkListService.swift
//  SalonApp
//
//  Created by engin gülek on 8.09.2023.
//

import Foundation

protocol BookMarkListServiceInterface {
    func fetchBookMarkList(userId:Int,completion:@escaping(Result<[BookMarkListArtist]?,Error> ) -> ())
    func deleteArtistToBookMarkList(id: Int, completion: @escaping (Result<MessageResult, Error>) -> ())
}

final class BookMarkListService : BookMarkListServiceInterface  {
    static let shared = BookMarkListService()
    func fetchBookMarkList(userId: Int, completion: @escaping (Result<[BookMarkListArtist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .bookMarkListArtist(userId), responseClass: DataResult<BookMarkListArtist>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
    
   
    
    func deleteArtistToBookMarkList(id: Int, completion: @escaping (Result<MessageResult, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .deleteArtistFromBookMarkList(id), responseClass: MessageResult.self) { response in
            switch  response {
            case .success(let success):
                if let result = success {
                    completion(.success(result))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
}
