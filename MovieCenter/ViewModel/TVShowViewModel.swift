//
//  TVShowViewModel.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import Foundation

class TVShowViewModel : ObservableObject {
    @Published var tvShows = [TVShow]()
    @Published var recomendations = [TVShow]()
    
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
                self.recomendations = data.results
            case .failure(let error):
                print(error)
            }
        })
    }
}