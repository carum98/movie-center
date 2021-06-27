//
//  CastViewModel.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 26/6/21.
//

import Foundation

class CastViewModel: ObservableObject {
    @Published var cast : Cast
    
    var session = URLSession.shared
    var client:Client
    
    init(cast : Cast) {
        client = Client(session: self.session)
        self.cast = cast
    }
    
    
    func fetchCastDetail() {
        client.getCastDetail(type: CastDetailData.self, id: cast.id, complete: { result in
            switch result {
            case .success(let data):
                print(data)
                self.cast.detail = data
            case .failure(let error):
                print(error)
            }
        })
    }
}
