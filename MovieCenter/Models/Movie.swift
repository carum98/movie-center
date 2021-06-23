//
//  Movie.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import Foundation

struct Movies : Identifiable, Codable {
    var id: Int
    var originalTitle : String
    var overview : String
    var backdropPath : String
    var posterPath : String
    var generes : [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case generes =  "genre_ids"
    }
}
