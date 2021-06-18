//
//  Client.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import Foundation

import Foundation

class Client: NetworkGeneric {
    let baseURL = "https://api.themoviedb.org/3/"
    let apiKey = "1a59911f322d3f3e7ef6b355beaed13f"
    
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getMovies<T: Decodable>(type:T.Type, complete: @escaping (Result<T, ApiError>) -> Void) {
        let path = "movie/now_playing"
        let url = URL(string: "\(baseURL)\(path)?api_key=\(apiKey)&language=es-ES")
        let request = URLRequest(url: url!)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    
}
