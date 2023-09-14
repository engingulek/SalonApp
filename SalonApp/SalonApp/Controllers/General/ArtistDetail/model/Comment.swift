//
//  Comment.swift
//  SalonApp
//
//  Created by engin gülek on 28.08.2023.
//

import Foundation

struct Comment:Decodable {
    let id : Int
    let imageurl:String
    let commenter : String
    let comment:String
    let rating:Double
    let commentdate : String
}
