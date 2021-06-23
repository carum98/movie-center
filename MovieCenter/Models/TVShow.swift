//
//  TVShow.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import Foundation

struct TVShow : Identifiable, Codable {
    var id : Int
    var originalName : String
    var overview : String
    var backdropPath : String
    var posterPath : String
    var firstAirDate : String
    var voteAverage : Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
    }
}
