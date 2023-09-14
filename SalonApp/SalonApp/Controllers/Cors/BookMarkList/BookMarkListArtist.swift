//
//  BookMarkListArtist.swift
//  SalonApp
//
//  Created by engin gülek on 9.09.2023.
//

import Foundation

struct BookMarkListArtist : Decodable {
    let id:Int
    let artistId:Int
    let userId:Int
    let imageUrl:String
    let rating:Double
    let name:String
    let bestService:String
    let locationcity:String
    let pay:Double
    let number:String
}
