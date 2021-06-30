//
//  TVShowsDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowsDetail: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    let tvShow: TVShow
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var favorito:Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                ZStack(alignment: .top) {
                    Image(uiImage: "https://image.tmdb.org/t/p/w92\(tvShow.backdropPath ?? "")".load())
                        .resizable()
                        .frame(height: 180)
                        .blur(radius: 20)
                    
                    VStack(alignment: .leading, spacing: 40) {
                        HStack(alignment: .bottom, spacing: 20) {
                            Image(uiImage: "https://image.tmdb.org/t/p/w92\(tvShow.posterPath ?? "")".load())
                            .resizable()
                            .frame(width: 100, height: 150, alignment: .center)
                            .cornerRadius(30)

                            VStack {
                                HStack(alignment: .bottom) {
                                    VStack(alignment: .leading, spacing: 20) {
                                        Text("Año: \(String(Array(tvShow.firstAirDate)[0..<4]))")
                                            .bold()
                                        Text("Temporas: \(tvShow.detail?.numberOfSeasons ?? 0)")
                                            .bold()
                                        Text("Episodios: \(tvShow.detail?.numberOfEpisodes ?? 0)")
                                            .bold()
                                    }
                                    Spacer()
                                    Image(systemName: favorito ? "star.fill" : "star")
                                        .foregroundColor(favorito ? Color(UIColor.yellow) : Color(UIColor.white))
                                        .padding(20)
                                        .onTapGesture {
                                            let fav = Favoritos(context: managedObjectContext)
                                            fav.nombre = tvShow.originalName
                                            fav.id = Int32(tvShow.id)
                                            fav.imagen = tvShow.posterPath
                                            fav.tipo = "TV"
                                            if !favorito {
                                                PersistanceController.shared.guardar()
                                                favorito.toggle()
                                            } else {
                                                PersistanceController.shared.eliminarFavoritoEspecifico(id: fav.id)
                                                favorito.toggle()
                                            }
                                        }
                                }
                            }
                        }.padding(20)
                        
                        VStack(alignment: .leading) {
                            Text("Sinopsis")
                                .font(.title)
                            Text(tvShow.overview)
                        }
                        
                        if let genres = tvShow.detail?.genres {
                            ListGenres(genres: genres)
                        }
                        
                        if let seasons = tvShow.detail?.seasons {
                            ListSeasons(seasons: seasons, tvShow: tvShow)
                        }
                        
                        
                        if let cast = tvShow.cast {
                            ListCast(cast: cast)
                        }
                        
                        if let recomendations = tvShow.recomendations {
                            ListRecomendation(recomendations: recomendations)
                        }
                        if let video = tvShow.videos?.results.first?.key {
                            Trailer(key: video).frame(height: 300, alignment: .center)
                                
                            
                        }
                        if let company1 = tvShow.detail?.networks[0], let company2 = tvShow.detail?.productionCompanies[0] {
                            TVShowCompany(company1: company1, company2: company2)
                        }
                        
                        
                    }
                    
                }
                .navigationBarTitle(tvShow.originalName, displayMode: .inline)
            }
            if viewModel.cargaTotal < 4 {
                Loading().frame(width: 50, height: 75, alignment: .center)
            }
        }
        .onAppear() {
            let index = viewModel.tvShows.firstIndex(where: { $0.id == tvShow.id })

            if ((viewModel.tvShows[index!].recomendations) == nil) {
                viewModel.fetchRecomendation(tvId: tvShow.id)
            } else {
                viewModel.cargaTotal = 5
            }

            if ((viewModel.tvShows[index!].detail) == nil) {
                viewModel.fetchDatail(tvId: tvShow.id)
            }

            if ((viewModel.tvShows[index!].cast) == nil) {
                viewModel.fetchCast(tvId: tvShow.id)
            }
            if ((viewModel.tvShows[index!].videos) == nil) {
                viewModel.fetchTvVideos(tvId: tvShow.id)
            }
            favorito = PersistanceController.shared.verificarFavorito(id: Int32(tvShow.id))
        }
        
    }
}
struct TVShowCompany: View {
    let company1 : Company
    let company2 : Company
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Productoras")
                .font(.title)
            Image(uiImage: "https://image.tmdb.org/t/p/w92\( company1.logoPath ?? "" )".load())
            .padding(8)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
            )
            Image(uiImage: "https://image.tmdb.org/t/p/w92\( company2.logoPath ?? "")".load())
            .padding(8)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
             )
        }
    }
}

struct ListSeasons: View {
    let seasons : [Seasons]
    let tvShow: TVShow
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Temporadas")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(seasons) { item in
                        if let image = item.posterPath {
                            NavigationLink(destination: SeasonDetail(season: item, tvShow: tvShow), label: {
                                VStack(alignment: .leading) {
                                    Image(uiImage: "https://image.tmdb.org/t/p/w92\(image)".load())
                                        .resizable()
                                        .frame(width: 150, height: 250, alignment: .center)
                                        .cornerRadius(20)
                                    Text("\(item.name)")
                                        .font(.title3)
                                    Text("Episodios: \(item.episodeCount ?? 0)")
                                        .font(.subheadline)
                                }.padding(.vertical, 20)
                            }).buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
    }
}

struct ListRecomendation: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    let recomendations : [TVShow]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recomendaciones")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(recomendations) { item in
                        NavigationLink(
                            destination: TVShowsDetail(tvShow: viewModel.tvShows.first(where: { data in data.id == item.id }) ?? viewModel.tvShows[0], favorito: false),
                            label: {
                                Image(uiImage: "https://image.tmdb.org/t/p/w185\(item.posterPath ?? "")".load())
                                    .resizable()
                                    .frame(width: 150, height: 250, alignment: .center)
                                    .cornerRadius(20)
                            }
                        )
                    }
                }
            }
        }
    }
}
