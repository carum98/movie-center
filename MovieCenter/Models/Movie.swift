//
//  Movie.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import Foundation

struct Movies : Identifiable, Codable {
    var id: Int
    var original_title : String
    var overview : String
}
