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
    
    func getTVShows<T: Decodable>(type:T.Type, complete: @escaping (Result<T, ApiError>) -> Void) {
        let path = "tv/on_the_air"
        let url = URL(string: "\(baseURL)\(path)?api_key=\(apiKey)&language=es-ES")
        let request = URLRequest(url: url!)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getMoviesRecomendation<T: Decodable>(type:T.Type, movieId : Int,complete: @escaping (Result<T, ApiError>) -> Void) {
        let path = "/movie/\(movieId)/recommendations"
        let url = URL(string: "\(baseURL)\(path)?api_key=\(apiKey)&language=es-ES")
        let request = URLRequest(url: url!)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getTVShowsRecomendation<T: Decodable>(type:T.Type, tvId : Int,complete: @escaping (Result<T, ApiError>) -> Void) {
        let path = "/tv/\(tvId)/recommendations"
        let url = URL(string: "\(baseURL)\(path)?api_key=\(apiKey)&language=es-ES")
        let request = URLRequest(url: url!)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getMoviesRecomendationRegion<T: Decodable>(type:T.Type, codRegion : String,complete: @escaping (Result<T, ApiError>) -> Void) {
        let path = "movie/popular"
        let url = URL(string: "\(baseURL)\(path)?api_key=\(apiKey)&language=es-ES&region=\(codRegion)")
        let request = URLRequest(url: url!)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
}
