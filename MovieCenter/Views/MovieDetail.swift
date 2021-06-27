//
//  MovieDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import SwiftUI

struct MovieDetail: View {
    @EnvironmentObject var viewModel : MoviesViewModel
    let movie : Movies
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var favorito:Bool
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                Image(uiImage: "https://image.tmdb.org/t/p/w200\(movie.backdropPath)".load())
                    .resizable()
                    .frame(height: 180)
                    .blur(radius: 20)
             
                VStack(alignment: .leading, spacing: 40) {
                    HStack(alignment: .bottom, spacing: 20) {
                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(movie.posterPath)".load())
                        .resizable()
                        .frame(width: 100, height: 150, alignment: .center)
                        .cornerRadius(30)
                        
                        VStack {
                            HStack(alignment: .bottom) {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("Año: \(String(Array(movie.releaseDate)[0..<4]))").bold()
                                    Text("Calificacion: \(String(format:"%.1f", movie.voteAverage)) / 10").bold()
                                }
                                Spacer()
                                Image(systemName: favorito ? "star.fill" : "star")
                                    .foregroundColor(favorito ? Color(UIColor.yellow) : Color(UIColor.white))
                                    .padding(20)
                                    .onTapGesture {
                                        let fav = Favoritos(context: managedObjectContext)
                                        fav.nombre = movie.originalTitle
                                        fav.id = Int32(movie.id)
                                        fav.imagen = movie.posterPath
                                        fav.tipo = "MV"
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
                        Text(movie.overview)
                    }
                    
                    if let genres = movie.detail?.genres {
                        ListGenres(genres: genres)
                    }
                    
                    if let cast = movie.cast {
                        ListCast(cast: cast)
                    }
                    
                    if let recomendations = movie.recomendations {
                        ListRecomendationn(recomendations: recomendations)
                    }
                    
                    if let companies = movie.detail?.productionCompanies {
                        Production(companies: companies)
                    }
                }
                .navigationBarTitle(movie.originalTitle, displayMode: .inline)
            }
        }
        .onAppear {
            let index = viewModel.movies.firstIndex(where: { $0.id == movie.id })
            
            if ((viewModel.movies[index!].recomendations) == nil) {
                viewModel.fetchRecomendation(movieId: movie.id)
            }
            
            if ((viewModel.movies[index!].detail) == nil) {
                viewModel.fetchDetail(movieId: movie.id)
            }
            
            if ((viewModel.movies[index!].cast) == nil) {
                viewModel.fetchCast(movieId: movie.id)
            }
            favorito = PersistanceController.shared.verificarFavorito(id: Int32(movie.id))
        }
    }
}


struct ListRecomendationn: View {
    let recomendations : [Movies]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recomendaciones")
                .font(.title)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(recomendations) { item in
                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(item.posterPath)".load())
                            .resizable()
                            .frame(width: 150, height: 250, alignment: .center)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

struct Production : View {
    let companies : [Company]
    
    var body: some View {
        VStack {
            Text("Productoras")
                .font(.title)
            ForEach(companies) { item in
                if let image = item.logoPath {
                    Image(uiImage: "https://image.tmdb.org/t/p/w200\(image)".load())
                    .padding(8)
                    .background(
                      RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                    )
                }
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: Movies(id: 1,
          originalTitle: "Cruella",
          overview: "\"Cruella\" se sumerge en la juventud rebelde de uno de los villanos más conocidos -y más de moda-, nada menos que la legendaria Cruella de Vil. Emma Stone encarna a Estella, alias Cruella, junto a Emma Thompson como la Baronesa, la directora de una prestigiosa firma de moda que convierte a Estella en una incipiente diseñadora. La cinta está ambientada en el contexto del punk-rock londinense de los 70.  ( https://stream4k.xyz/en/movie/337404/cruella )",
          backdropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg",
          posterPath: "/qb28nkLZV0v6yJZZRpJYl0LE35N.jpg", releaseDate: "2021-06-17", voteAverage: 6,
          generes: [38,25]), favorito: false)
    }
}
