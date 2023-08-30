//
//  ArtistDetail.swift
//  SalonApp
//
//  Created by engin gülek on 28.08.2023.
//

import Foundation

struct ArtistDetail : Decodable {
    let id :Int
    let imageUrl:String
    let rating:Double
    let name:String
    let bestService:String
    let locationcity:String
    let pay:Double
    let about:String
}
