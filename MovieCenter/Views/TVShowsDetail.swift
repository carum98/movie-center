//
//  TVShowsDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowsDetail: View {
    let tvShow : TVShow
    var viewModel : TVShowViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                Image(uiImage: "https://image.tmdb.org/t/p/w500\(tvShow.backdropPath)".load())
                    .resizable()
                    .frame(width: 400, height: 300)
                Text(tvShow.originalName)
                Text(tvShow.overview)
                Spacer()
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 20) {
                        ForEach(viewModel.recomendations) { item in
                            Image(uiImage: "https://image.tmdb.org/t/p/w500\(item.posterPath)".load())
                                .resizable()
                                .frame(width: 200, height: 300, alignment: .center)
                        }
                    }
                }
            }
            Image(uiImage: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)".load())
                .resizable()
                .frame(width: 200, height: 300, alignment: .center)
        }
        .navigationBarTitle(tvShow.originalName)
        .onAppear {
            viewModel.fetchRecomendation(tvId: tvShow.id)
        }
    }
}

struct TVShowsDetail_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsDetail(tvShow: TVShow(id: 1, originalName: "Loki", overview: "Loki, el impredecible villano Loki (Hiddleston) regresa como el Dios del engaño en una nueva serie tras los acontecimientos de Avengers", backdropPath: "/ykElAtsOBoArgI1A8ATVH0MNve0.jpg", posterPath: "/kAHPDqUUciuObEoCgYtHttt6L2Q.jpg"), viewModel: TVShowViewModel())
    }
}
