//
//  TVShowViewModel.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import Foundation

class TVShowViewModel : ObservableObject {
    @Published var tvShows = [TVShow]()
    @Published var genres = [Genre]()
    @Published var regionTV = [TVShow]()
    @Published var cargando:Bool = false
    @Published var noEncontrada:Bool = false
    @Published var cargaTotal: Int = 0
    
    var session = URLSession.shared
    var client:Client
    
    init() {
        client = Client(session: self.session)
    }
   
    func fetchTVShows() {
        self.cargando = true
        client.getTVShows(type: ResultTVShows.self, complete: { result in
            switch result {
            case .success(let data):
                self.tvShows = data.results
                self.cargando = false
            case .failure(let error):
                print(error)
            }
        })
    }
    func fetchGenreTVShow() {
        self.cargando = true
        client.getGenreTVShow(type: ResultGenre.self, complete: { result in
            switch result {
            case .success(let data):
                self.genres = data.genres
                self.cargando = false
            case .failure(let error):
                print(error)
            }
        })
    }
    func fetchTvVideos(tvId : Int) {
        self.cargando = true
        client.getTvShowVideos(type: ResultVideos.self, tvId: tvId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.tvShows.firstIndex(where: { $0.id == tvId } ) {
                    self.tvShows[i].videos = data
                }
                self.cargando = false
                self.cargaTotal += 1
            case .failure(let error):
                print(error)
            }
        })
    }
    func fetchRegion(region : String) {
        self.cargando = true
        client.getTvRecomendationRegion(type: ResultTVShows.self, codRegion: region, complete: { result in
            switch result {
            case .success(let data):
                self.regionTV = data.results
                self.cargando = false
            case .failure(let error):
                print(error)
            }
        })
    }
    func fetchRecomendation(tvId : Int) {
        client.getTVShowsRecomendation(type: ResultTVShows.self, tvId: tvId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.tvShows.firstIndex(where: { $0.id == tvId } ) {
                    self.tvShows[i].recomendations = data.results
                    
                    for data2 in data.results {
                        let isContain : Bool = self.tvShows.contains(where: { $0.id == data2.id })

                        if (!isContain) {
                            self.tvShows.append(data2)
                        }
                    }
                    self.cargaTotal += 1
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    func fetchSearchTv(name : String) {
        self.cargando = true
        self.noEncontrada = false
        client.getSearchTv(type: ResultTVShows.self, name: name, complete: { result in
            switch result {
            case .success(let data):
                    self.noEncontrada = false
                    self.tvShows = data.results
                    self.cargando = false
            case .failure(_):
                self.noEncontrada = true
                self.cargando = false
            }
        })
    }
    func fetchDatail(tvId : Int) {
        self.cargando = true
        client.getTVShowsDetail(type: TVShowDetail.self, tvId: tvId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.tvShows.firstIndex(where: { $0.id == tvId } ) {
                    self.tvShows[i].detail = data
                    self.cargando = false
                    self.cargaTotal += 1
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchCast(tvId : Int) {
        self.cargando = true
        client.getTVShowsCast(type: ResultTVShowCast.self, tvId: tvId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.tvShows.firstIndex(where: { $0.id == tvId } ) {
                    self.tvShows[i].cast = data.cast
                    self.cargando = false
                    self.cargaTotal += 1
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchSeason(tvId : Int, seasonNumber : Int) {
        client.getSeason(type: ResultEpisodes.self, tvId: tvId, seasonNumber: seasonNumber,complete: { result in
            switch result {
            case .success(let data):
                if let i = self.tvShows.firstIndex(where: { $0.id == tvId } ) {
                    if let i2 = self.tvShows[i].detail?.seasons.firstIndex(where: { $0.seasonNumber == seasonNumber }) {
                        print("Episodios \(data.episodes.count)")
                        self.tvShows[i].detail?.seasons[i2].episodes = data.episodes
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchFullTVShow(tvId : Int) {
        self.cargando = true
        client.getTVShowsDetail(type: TVShow.self, tvId: tvId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.tvShows.firstIndex(where: { $0.id == tvId } ) {
                    self.tvShows[i] = data
                }else{
                    self.tvShows.append(data)
                }
                self.cargando = false
            case .failure(let error):
                print(error)
            }
        })
    }
}
