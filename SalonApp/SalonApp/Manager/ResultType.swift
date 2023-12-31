//
//  DataResult.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation


struct DataResult<T:Decodable> : Decodable {
    let success : Bool
    let message:String
    var data:[T]
}

struct MessageResult:  Decodable {
    let success:Bool
    let message:String
}

struct SingInResult : Decodable {
    let success : Bool
    let message:String
    let data : User?
}
