//
//  MoviesViewModel.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import Foundation

class MoviesViewModel : ObservableObject {
    @Published var movies = [Movies]()
    @Published var recomendations = [Movies]()
    
    var session = URLSession.shared
    var client:Client
    
    init() {
        client = Client(session: self.session)
    }
   
    func fetchMovies() {
        client.getMovies(type: Results.self, complete: { result in
            switch result {
            case .success(let data):
                self.movies = data.results
            case .failure(let error):
                print(error)
            }
        })
    }
    
    
    func fetchRecomendation(movieId : Int) {
        client.getMoviesRecomendation(type: Results.self, movieId: movieId, complete: { result in
            switch result {
            case .success(let data):
                self.recomendations = data.results
            case .failure(let error):
                print(error)
            }
        })
    }
}
