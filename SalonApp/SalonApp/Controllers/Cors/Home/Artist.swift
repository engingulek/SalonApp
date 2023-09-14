//
//  TopArtist.swift
//  SalonApp
//
//  Created by engin gülek on 24.08.2023.
//

import Foundation

struct Artist:Decodable {
    let id: Int
    let imageUrl:String
    let rating : Double
    let name: String
    let bestService : String
    let locationcity:String
    let pay:Double
}
