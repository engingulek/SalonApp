//
//  ArtistDetilService.swift
//  SalonApp
//
//  Created by engin gülek on 28.08.2023.
//

import Foundation

protocol ArtistDetailServiceInterfece {
    func fetchArtistDetail(artistId:Int,completion:@escaping(Result<[ArtistDetail]?,Error> ) -> ())
}


final class ArtistDetailService : ArtistDetailServiceInterfece {
    static let shared = ArtistDetailService()
    func fetchArtistDetail(artistId:Int,completion: @escaping (Result<[ArtistDetail]?, Error>) -> ()) {
        NetworkManager.shared.fetch(target: .artistDetail(artistId), responseClass: ArtistDetail.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                            completion(.failure(failure))
            }
        }
        
    }
    
    
}
