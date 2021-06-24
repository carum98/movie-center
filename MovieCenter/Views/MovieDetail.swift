//
//  MovieDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import SwiftUI

struct MovieDetail: View {
    let movie : Movies
    var viewModel : MoviesViewModel
    
    var body: some View {
            ZStack(alignment: .leading) {
                VStack {
                    Image(uiImage: "https://image.tmdb.org/t/p/w200\(movie.backdropPath)".load())
                        .resizable()
                        .frame(width: 400, height: 300)
                    Text(movie.originalTitle)
                    Text(movie.overview)
                    Spacer()
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 20) {
                            ForEach(viewModel.recomendations) { item in
                                Image(uiImage: "https://image.tmdb.org/t/p/w200\(item.posterPath)".load())
                                    .resizable()
                                    .frame(width: 200, height: 300, alignment: .center)
                            }
                        }
                    }
                }
                Image(uiImage: "https://image.tmdb.org/t/p/w200\(movie.posterPath)".load())
                    .resizable()
                    .frame(width: 200, height: 300, alignment: .center)
            
                Spacer()
            }
            .navigationBarTitle(movie.originalTitle)
            .onAppear {
                viewModel.fetchRecomendation(movieId: movie.id)
            }
        }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: Movies(id: 1,
          originalTitle: "Cruella",
          overview: "\"Cruella\" se sumerge en la juventud rebelde de uno de los villanos más conocidos -y más de moda-, nada menos que la legendaria Cruella de Vil. Emma Stone encarna a Estella, alias Cruella, junto a Emma Thompson como la Baronesa, la directora de una prestigiosa firma de moda que convierte a Estella en una incipiente diseñadora. La cinta está ambientada en el contexto del punk-rock londinense de los 70.  ( https://stream4k.xyz/en/movie/337404/cruella )",
          backdropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg",
          posterPath: "/qb28nkLZV0v6yJZZRpJYl0LE35N.jpg",
          generes: [38,25]), viewModel: MoviesViewModel())
    }
}
