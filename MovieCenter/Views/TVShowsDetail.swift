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
        ScrollView {
            ZStack(alignment: .top) {
                Image(uiImage: "https://image.tmdb.org/t/p/w200\(tvShow.backdropPath)".load())
                    .resizable()
                    .frame(height: 180)
                    .blur(radius: 20)
                
                VStack(alignment: .leading, spacing: 40) {
                    HStack(alignment: .bottom, spacing: 20) {
                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(tvShow.posterPath)".load())
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
                                        print("Verificar estad favorito = \(favorito)")
                                        if !favorito {
                                            PersistanceController.shared.guardar()
                                            favorito.toggle()
                                        } else {
                                            print("Entro a eliminar")
                                            PersistanceController.shared.eliminarFavoritoEspecifico(id: fav.id)
                                            favorito.toggle()
                                        }
                                    }
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
                        ListSeasons(seasons: seasons)
                    }
                    
                    
                    if let cast = tvShow.cast {
                        ListCast(cast: cast)
                    }
                    
                    if let recomendations = tvShow.recomendations {
                        ListRecomendation(recomendations: recomendations)
                    }
                    
                    if let company1 = tvShow.detail?.networks[0], let company2 = tvShow.detail?.productionCompanies[0] {
                        TVShowCompany(company1: company1, company2: company2)
                    }
                    
                    
                }
                
            }
            .navigationBarTitle(tvShow.originalName, displayMode: .inline)
        }
        .onAppear() {
            let index = viewModel.tvShows.firstIndex(where: { $0.id == tvShow.id })

            if ((viewModel.tvShows[index!].recomendations) == nil) {
                viewModel.fetchRecomendation(tvId: tvShow.id)
            }

            if ((viewModel.tvShows[index!].detail) == nil) {
                viewModel.fetchDatail(tvId: tvShow.id)
            }

            if ((viewModel.tvShows[index!].cast) == nil) {
                viewModel.fetchCast(tvId: tvShow.id)
            }
            
            favorito = PersistanceController.shared.verificarFavorito(id: Int32(tvShow.id))
        }
        
    }
}

struct ListGenres: View {
    let genres : [Genre]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres) { item in
                    Text(verbatim: item.name)
                      .padding(8)
                      .background(
                        RoundedRectangle(cornerRadius: 8)
                          .fill(Color.gray.opacity(0.2)))
                }
            }
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
            Image(uiImage: "https://image.tmdb.org/t/p/w200\( company1.logoPath ?? "" )".load())
            .padding(8)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
            )
            Image(uiImage: "https://image.tmdb.org/t/p/w200\( company2.logoPath ?? "")".load())
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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Temporadas")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(seasons) { item in
                        if let image = item.posterPath {
                            VStack(alignment: .leading) {
                                Image(uiImage: "https://image.tmdb.org/t/p/w200\(image)".load())
                                    .resizable()
                                    .frame(width: 150, height: 250, alignment: .center)
                                    .cornerRadius(20)
                                Text("\(item.name)")
                                    .font(.title3)
                                Text("Episodios: \(item.episodeCount ?? 0)")
                                    .font(.subheadline)
                            }.padding(.vertical, 20)
                        }
                    }
                }
            }
        }
    }
}

struct ListRecomendation: View {
    let recomendations : [TVShow]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recomendaciones")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(recomendations) { item in
                        NavigationLink(
                            destination: TVShowsDetail(tvShow: item, favorito: false),
                            label: {
                                Image(uiImage: "https://image.tmdb.org/t/p/w200\(item.posterPath)".load())
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

struct ListCast: View {
    let cast : [Cast]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Reparto")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(cast ) { item in
                        NavigationLink(
                            destination: CastDetail(viewModel: CastViewModel(cast: item)),
                            label: {
                                VStack(alignment: .leading) {
                                    if let image = item.profilePath {
                                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(image)".load())
                                            .resizable()
                                            .frame(width: 150, height: 250, alignment: .center)
                                            .cornerRadius(20)
                                    }

                                    Text("\(item.name)")
                                        .font(.title3)
                                    Text("\(item.character)")
                                        .font(.subheadline)
                                }
                                .frame(maxWidth: 150)
                                .padding(.vertical, 20)
                            }
                        ).buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}
