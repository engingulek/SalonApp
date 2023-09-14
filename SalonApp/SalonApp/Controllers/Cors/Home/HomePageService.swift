//
//  HomePageService.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation
import UIKit.UIApplication
protocol HomePageServiceInterface {

    func fetchTopArtists(completion:@escaping(Result<[Artist]?,Error> ) -> ())
    func fetchBookMarkList(userId: Int, completion: @escaping (Result<[BookMarkListArtist]?, Error>) -> ())
    func addArtistToBookMarkList(parameters:[String:Any],completion:@escaping(Result<MessageResult,Error>)->())
    func deleteArtistToBookMarkList(id:Int,completion:@escaping(Result<MessageResult,Error>)->())
    func fetchUserInfo(completion:@escaping(Result<[User],Error>)->())

}

private let appDelegate = UIApplication.shared.delegate as! AppDelegate
final class HomePageService :  HomePageServiceInterface{
    private let context = appDelegate.persistentContainer.viewContext
    static let shared = HomePageService()
    
    /// Fetch Book Mark List -- for icon type
    /// - Parameters:
    ///   - userId: User ID
    ///   - completion: The bookmark list will be returned according to the user ID.
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
    
    
    /// Fetct all top artist
    /// - Parameter completion: All the best artists will be invited
    func fetchTopArtists(completion: @escaping (Result<[Artist]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .topArtists, responseClass: DataResult<Artist>.self) { response in
            switch response {
            case .success(let success):
                let list  = success?.data
                completion(.success(list))
            case .failure(let failure):
                completion(.failure(failure))
             
            }
        }
    }
    
    /// Add Artist Book Mark List
    /// - Parameters:
    ///   - parameters: Artist and user data to be added to the bookmark list
    ///   - completion: Success or failure response returned as a result of the addition process
    func addArtistToBookMarkList(parameters:[String:Any],completion:@escaping(Result<MessageResult,Error>)->()) {
        NetworkManager.shared.fetch(target: .addArtistToBookMarkList(parameters), responseClass: MessageResult.self) { response in
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
    
    /// Delete Artist To Book Mark List
    /// - Parameters:
    ///   - id: User Iid
    ///   - completion: Success or failure response returned as a result of the delete operation
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
    
    
    func fetchUserInfo(completion: @escaping (Result<[User], Error>) -> ()) {
        var userInfo : [UserInfo] = []
        do{
            if userInfo.isEmpty {
                completion(.success([]))
            }else{
                userInfo = try context.fetch(UserInfo.fetchRequest())
                let user = User(id: Int(userInfo[0].id ), name: userInfo[0].name ?? "", surname: userInfo[0].surname ?? "", email: userInfo[0].email ?? "", imageUrl: userInfo[0].imageurl ?? "")
                completion(.success([user]))
            }
           
        }catch{
            completion(.failure(error))
        }
        
        
    }
    
}
