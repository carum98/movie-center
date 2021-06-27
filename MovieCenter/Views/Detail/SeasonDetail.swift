//
//  SeasonDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 26/6/21.
//

import SwiftUI

struct SeasonDetail: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    var season : Seasons
    var tvShow: TVShow
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack(alignment: .bottom, spacing: 20) {
                Image(uiImage: "https://image.tmdb.org/t/p/w200\(season.posterPath ?? "")".load())
                .resizable()
                .frame(width: 100, height: 150, alignment: .center)
                .cornerRadius(30)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Temporada: \(season.seasonNumber )")
                        .bold()
                    Text("Episodios: \(season.episodeCount ?? 0)")
                        .bold()
                }
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text("Descripcion")
                    .font(.title)
                Text(season.overview )
            }
            
            VStack(alignment: .leading) {
                Text("Episodios")
                    .font(.title)
                
                List {
                    ForEach(season.episodes ?? [], content: { item in
                        NavigationLink(
                            destination: EpisodeDetail(episode: item),
                            label: {
                                Text(item.name)
                            }
                        )
                    })
                }
            }
        }.padding(20)
        .onAppear {
            if (season.episodes == nil) {
                viewModel.fetchSeason(tvId: tvShow.id, seasonNumber: season.seasonNumber)
            }
        }
    }
}

struct EpisodeDetail : View {
    var episode: Episodes
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            if let image = episode.stillPath {
                Image(uiImage: "https://image.tmdb.org/t/p/w500\(image)".load())
                    .resizable()
                    .frame(height: 250, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Episodio: \(episode.episodeNumber)")
                    .bold()
                Text("Nombre: \(episode.name)")
                    .bold()
                Text("Fecha de emision: \(episode.airDate)")
                    .bold()
            }
            
            
            
            VStack(alignment: .leading) {
                Text("Descripcion")
                    .font(.title)
                Text(episode.overview )
            }
            
            Spacer()
        }
    }
}
