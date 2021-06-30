import SwiftUI

struct MoviesRegionList: View {
    @EnvironmentObject var viewModel : MoviesViewModel
    var laRegion:String
    var generos:[Genre]
    var peliculas:[Movies]
    var favoritos:Bool
    func ObtengaLasPeliculasPorGenero(lasPelicula:[Movies], genero:Int) -> [Movies]{
        let peliculas:[Movies] = lasPelicula.filter({ (movie) -> Bool in
            if(movie.generes.contains(genero) && movie.backdropPath != nil && movie.posterPath != nil){
                return true
            }
            return false
        })
        return peliculas
    }
    var body: some View {
        ScrollView(.vertical){
            LazyVStack(spacing: 20) {
                ForEach(generos, id: \.id){ genere in
                    let lasPeliculas:[Movies] = ObtengaLasPeliculasPorGenero(lasPelicula: peliculas,genero: genere.id)
                    if (lasPeliculas.count > 0){
                        VStack(alignment: .leading, spacing: 6) {
                            Text(genere.name).font(.title).frame(alignment: .leading)
                            ScrollView(.horizontal){
                                LazyHStack(spacing: 20) {
                                    ForEach(lasPeliculas, id: \.id){ movie in
                                        NavigationLink(
                                            destination: MovieDetail(movie: movie, favorito: favoritos) ,
                                            label: {
                                                LazyVStack(spacing: 1) {
                                                    Image(uiImage: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")".load())
                                                        .resizable()
                                                        .frame(width: 100, height: 150, alignment: .center)
                                                        .cornerRadius(30)
                                                }
                                            }
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
