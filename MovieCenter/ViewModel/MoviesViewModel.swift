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
    @Published var cargando:Bool = false
    @Published var noEncontrada:Bool = false
    var session = URLSession.shared
    var client:Client
    
    init() {
        client = Client(session: self.session)
    }
   
    func fetchMovies() {
        self.cargando = true
        client.getMovies(type: Results.self, complete: { result in
            switch result {
            case .success(let data):
                self.movies = data.results
                self.cargando = false
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchMovie() {
        client.getMovies(type: Movies.self, complete: { result in
            switch result {
            case .success(let data):
                self.movies.append(data)
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
                    
                    for data2 in data.results {
                        let isContain : Bool = self.movies.contains(where: { $0.id == data2.id })

                        if (!isContain) {
                            self.movies.append(data2)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchDetail(movieId : Int) {
        self.cargando = true
        client.getMovieDetail(type: MovieDataDetail.self, movieId: movieId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.movies.firstIndex(where: { $0.id == movieId } ) {
                    self.movies[i].detail = data
                }
                self.cargando = false
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchRegion(region : String) {
        self.cargando = true
        client.getMoviesRecomendationRegion(type: Results.self, codRegion: region, complete: { result in
            switch result {
            case .success(let data):
                self.regionMovies = data.results
                self.cargando = false
            case .failure(let error):
                print(error)
            }
        })
    }
    func fetchGenreMovies() {
        self.cargando = true
        client.getGenreMovies(type: ResultGenre.self, complete: { result in
            switch result {
            case .success(let data):
                self.genres = data.genres
                self.cargando = false
            case .failure(let error):
                print(error)
            }
        })
    }
    func fetchSearch(name : String) {
        self.cargando = true
        self.noEncontrada = false
        client.getSearchMovies(type: Results.self, name: name, complete: { result in
            switch result {
            case .success(let data):
                    self.noEncontrada = false
                    self.movies = data.results
                    self.cargando = false
            case .failure(_):
                self.noEncontrada = true
                self.cargando = false
                    //print(error)
            }
        })
    }
    func fetchCast(movieId : Int) {
        client.getMovieCast(type: ResultTVShowCast.self, movieId: movieId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.movies.firstIndex(where: { $0.id == movieId } ) {
                    self.movies[i].cast = data.cast
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
