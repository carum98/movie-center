//
//  Result.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import Foundation

struct Results : Codable {
    let results : [Movies]
}

struct ResultTVShows : Codable {
    let results : [TVShow]
}

struct ResultTVShowCast : Codable {
    let cast : [Cast]
}

struct ResultGenre : Codable{
    let genres : [Genre]
}
