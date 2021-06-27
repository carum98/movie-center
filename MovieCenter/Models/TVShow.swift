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
    var detail : TVShowDetail?
    var recomendations : [TVShow]?
    var cast : [Cast]?
    var generes : [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case generes =  "genre_ids"
    }
}


struct TVShowDetail : Codable {
    var genres : [Genre]
    var numberOfEpisodes : Int
    var numberOfSeasons : Int
    var networks : [Company]
    var productionCompanies : [Company]
    var seasons : [Seasons]
    
    enum CodingKeys: String, CodingKey {
        case genres
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case networks
        case productionCompanies = "production_companies"
        case seasons
    }
}

struct Company : Codable, Identifiable {
    var id : Int
    var name : String
    var logoPath : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoPath = "logo_path"
    }
}

struct Seasons : Identifiable, Codable {
    var id : Int
    var name : String
    var overview : String
    var posterPath : String?
    var episodeCount : Int?
    var seasonNumber : Int
    var episodes : [Episodes]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case episodeCount = "episode_count"
        case seasonNumber = "season_number"
    }
}

struct Episodes : Identifiable, Codable {
    var id : Int
    var name : String
    var overview : String
    var episodeNumber : Int
    var stillPath : String?
    var airDate : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case episodeNumber = "episode_number"
        case stillPath = "still_path"
        case airDate = "air_date"
    }
}
