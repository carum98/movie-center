//
//  TVShowViewModel.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import Foundation

class TVShowViewModel : ObservableObject {
    @Published var tvShows = [TVShow]()
    
    var session = URLSession.shared
    var client:Client
    
    init() {
        client = Client(session: self.session)
    }
   
    func fetchTVShows() {
        client.getTVShows(type: ResultTVShows.self, complete: { result in
            switch result {
            case .success(let data):
                self.tvShows = data.results
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
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchDatail(tvId : Int) {
        client.getTVShowsDetail(type: TVShowDetail.self, tvId: tvId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.tvShows.firstIndex(where: { $0.id == tvId } ) {
                    self.tvShows[i].detail = data
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchCast(tvId : Int) {
        client.getTVShowsCast(type: ResultTVShowCast.self, tvId: tvId, complete: { result in
            switch result {
            case .success(let data):
                if let i = self.tvShows.firstIndex(where: { $0.id == tvId } ) {
                    self.tvShows[i].cast = data.cast
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
