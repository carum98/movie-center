//
//  TVShowsDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowsDetail: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    let tvShow : TVShow
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                HStack(alignment: .bottom, spacing: 20) {
                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(tvShow.posterPath)".load())
                        .resizable()
                        .frame(width: 100, height: 150, alignment: .center)
                        .cornerRadius(30)
                        
                        VStack {
                            HStack {
                                Spacer()
                                HStack {
                                    ForEach(0..<Int(tvShow.voteAverage)) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                            }
                            Spacer()
                            HStack(alignment: .bottom) {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text(tvShow.originalName)
                                    Text(tvShow.firstAirDate)
                                }
                                Spacer()
                                Image(systemName: "star.fill")
                                    .padding(20)
                            }
                        }
                        

                    }.padding(20)
                
                    HStack {
                        ForEach(tvShow.detail?.genres ?? []) { item in
                            Text(verbatim: item.name)
                              .padding(8)
                              .background(
                                RoundedRectangle(cornerRadius: 8)
                                  .fill(Color.gray.opacity(0.2))
                               )
                        }
                    };
                
                    Text("Sinopsis")
                        .font(.title)
                    Text(tvShow.overview)
                    
                    TVShowInfo(detail: tvShow.detail)
                
                    Text("Recomendaciones")
                        .font(.title)
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 20) {
                            ForEach(viewModel.recomendations) { item in
                                NavigationLink(
                                    destination: TVShowsDetail(tvShow: item) ,
                                    label: {
                                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(item.posterPath)".load())
                                            .resizable()
                                            .frame(width: 150, height: 250, alignment: .center)
                                            .cornerRadius(20)
                                    })

                            }
                        }
                    }
            }
            .navigationBarTitle(tvShow.originalName, displayMode: .inline)
        }
        
        .onAppear() {
            viewModel.fetchRecomendation(tvId: tvShow.id)
            viewModel.fetchDatail(tvId: tvShow.id)
        }
        .onDisappear() {
            viewModel.recomendations.removeAll()
        }
    }
}

struct TVShowInfo: View {
    let detail : TVShowDetail?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Informacion")
                .font(.title)
            Text("Temporas: \(detail?.numberOfSeasons ?? 0)")
            Text("Episodios: \(detail?.numberOfEpisodes ?? 0)")
        
            HStack {
                Image(uiImage: "https://image.tmdb.org/t/p/w200\( detail?.networks[0].logoPath ?? "")".load())
                    .resizable()
                    .frame(width: 100, height: 50, alignment: .center)
                    
                Text("Network: \(detail?.networks[0].name ?? "")")
            }
            .padding(8)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
            )
            HStack {
                Image(uiImage: "https://image.tmdb.org/t/p/w200\( detail?.productionCompanies[0].logoPath ?? "")".load())
                    .resizable()
                    .frame(width: 150, height: 50, alignment: .center)
                    
                Text("Productora: \(detail?.productionCompanies[0].name ?? "")")
            }
                .padding(8)
                .background(
                  RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                 )
        }
    }
}

struct TVShowsDetail_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsDetail(
            tvShow: TVShow(
                id: 1,
                originalName: "Loki",
                overview: "Loki, el impredecible villano Loki (Hiddleston) regresa como el Dios del engaño en una nueva serie tras los acontecimientos de Avengers",
                backdropPath: "/ykElAtsOBoArgI1A8ATVH0MNve0.jpg",
                posterPath: "/kAHPDqUUciuObEoCgYtHttt6L2Q.jpg",
                firstAirDate: "2021-02-13",
                voteAverage: 3,
                detail:
                    TVShowDetail(
                        genres: [Genre(id: 18, name: "Drama"), Genre(id: 20, name: "Sci-Fi & Fantasy")],
                        numberOfEpisodes: 8,
                        numberOfSeasons: 1,
                        networks: [Company(id: 2, name: "Disney+", logoPath: "/gJ8VX6JSu3ciXHuC2dDGAo2lvwM.png")],
                        productionCompanies: [Company(id: 1, name: "Marvel Studios", logoPath: "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png")]
                    )
            ))
            .preferredColorScheme(.dark)
            .environmentObject(TVShowViewModel())
    }
}


