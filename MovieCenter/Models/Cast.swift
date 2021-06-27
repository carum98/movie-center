//
//  Cast.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 26/6/21.
//

import Foundation


struct Cast : Identifiable, Codable {
    var id : Int
    var name : String
    var character : String
    var profilePath : String?
    var detail : CastDetailData?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }
}

struct CastDetailData : Identifiable, Codable {
    var id : Int
    var birthday : String
    var place_of_birth : String
    var biography : String
}
