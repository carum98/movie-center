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
        let url = buildPath(path: "movie/now_playing")
        let request = URLRequest(url: url)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getTVShows<T: Decodable>(type:T.Type, complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = buildPath(path: "tv/on_the_air")
        let request = URLRequest(url: url)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getMoviesRecomendation<T: Decodable>(type:T.Type, movieId : Int,complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = buildPath(path: "/movie/\(movieId)/recommendations")
        let request = URLRequest(url: url)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getTVShowsRecomendation<T: Decodable>(type:T.Type, tvId : Int,complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = buildPath(path: "/tv/\(tvId)/recommendations")
        let request = URLRequest(url: url)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getTVShowsCast<T: Decodable>(type:T.Type, tvId : Int,complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = buildPath(path: "/tv/\(tvId)/credits")
        let request = URLRequest(url: url)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getTVShowsDetail<T: Decodable>(type:T.Type, tvId : Int,complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = buildPath(path: "/tv/\(tvId)")
        let request = URLRequest(url: url)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getMoviesRecomendationRegion<T: Decodable>(type:T.Type, codRegion : String,complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = buildPath(path: "movie/popular")
        let request = URLRequest(url: url)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func getGenreMovies<T: Decodable>(type:T.Type,complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = buildPath(path: "genre/movie/list")
        let request = URLRequest(url: url)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    private func buildPath(path : String) -> URL {
        return URL(string: "\(baseURL)\(path)?api_key=\(apiKey)&language=es-ES")!
    }
}
