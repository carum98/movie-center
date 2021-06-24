//
//  MoviesViewModel.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import Foundation

class MoviesViewModel : ObservableObject {
    @Published var movies = [Movies]()
    @Published var regionMovies = [Movies]()
    @Published var genres = [Genre]()
    
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
                if let i = self.movies.firstIndex(where: { $0.id == movieId } ) {
                    self.movies[i].recomendations = data.results
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchDetail(movieId : Int) {
        client.getMovieDetail(type: MovieDataDetail.self, movieId: movieId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.movies.firstIndex(where: { $0.id == movieId } ) {
                    self.movies[i].detail = data
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchRegion(region : String) {
        client.getMoviesRecomendationRegion(type: Results.self, codRegion: region, complete: { result in
            switch result {
            case .success(let data):
                self.regionMovies = data.results
            case .failure(let error):
                print(error)
            }
        })
    }
    func fetchGenreMovies() {
        client.getGenreMovies(type: ResultGenre.self, complete: { result in
            switch result {
            case .success(let data):
                self.genres = data.genres
            case .failure(let error):
                print(error)
            }
        })
    }
}
