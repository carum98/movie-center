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
    var releaseDate : String
    var voteAverage : Float
    var generes : [Int]
    var detail : MovieDataDetail?
    var recomendations : [Movies]?
    var cast : [TVShowCast]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case generes =  "genre_ids"
    }
}

struct MovieDataDetail : Codable {
    var genres : [Genre]
    var productionCompanies : [Company]
    
    enum CodingKeys: String, CodingKey {
        case genres
        case productionCompanies = "production_companies"
    }
}
