//
//  User.swift
//  SalonApp
//
//  Created by engin gülek on 11.09.2023.
//

import Foundation


struct User : Decodable {
    let id:Int
    let name:String
    let surname:String
    let email:String
    let imageUrl:String
}
