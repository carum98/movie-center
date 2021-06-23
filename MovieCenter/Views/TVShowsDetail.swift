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
        ScrollView {
            ZStack(alignment: .leading) {
                VStack {
                    Image(uiImage: "https://image.tmdb.org/t/p/w300\(tvShow.backdropPath)".load())
                        .resizable()
                        .frame(height: 200)
                    HStack(alignment: .bottom) {
                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(tvShow.posterPath)".load())
                        .resizable()
                        .frame(width: 100, height: 150, alignment: .center)
                        VStack(alignment: .leading, spacing: 10.0) {
                            Text(tvShow.originalName)
                            Text(tvShow.firstAirDate)
                            HStack {
                                ForEach(0..<Int(tvShow.voteAverage)) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        Spacer()
                        Image(systemName: "star.fill")
                            .padding(20)
                    }
                    Text(tvShow.overview)
                    Spacer()
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 20) {
                            ForEach(viewModel.recomendations) { item in
                                NavigationLink(
                                    destination: TVShowsDetail(tvShow: item, viewModel: viewModel) ,
                                    label: {
                                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(item.posterPath)".load())
                                            .resizable()
                                            .frame(width: 150, height: 250, alignment: .center)
                                    })

                            }
                        }
                    }
                }

            }
            .navigationTitle(tvShow.originalName)
            .onAppear {
                viewModel.recomendations.removeAll()
                viewModel.fetchRecomendation(tvId: tvShow.id)
        }
        }
    }
}

struct TVShowsDetail_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsDetail(tvShow: TVShow(id: 1, originalName: "Loki", overview: "Loki, el impredecible villano Loki (Hiddleston) regresa como el Dios del engaño en una nueva serie tras los acontecimientos de Avengers", backdropPath: "/ykElAtsOBoArgI1A8ATVH0MNve0.jpg", posterPath: "/kAHPDqUUciuObEoCgYtHttt6L2Q.jpg", firstAirDate: "2021-02-13", voteAverage: 3), viewModel: TVShowViewModel())
            .preferredColorScheme(.dark)
    }
}
