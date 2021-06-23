import SwiftUI

struct MoviesRegionList: View {
    var viewModel : MoviesViewModel
    var laRegion:String
    func ObtengaLasPeliculasPorGenero(lasPelicula:[Movies], genero:Int) -> [Movies]{
        let peliculas:[Movies] = (lasPelicula.map {(movie)-> Movies in
            var theMovie:Movies?
            if(movie.generes.contains(genero)){
                theMovie = movie
            }
            return theMovie!
        })
        return peliculas
    }
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20) {
                ForEach(self.viewModel.genres, id: \.id){ genere in                  
                    LazyHStack(spacing: 20) {
                        ForEach(ObtengaLasPeliculasPorGenero(lasPelicula: self.viewModel.regionMovies,genero: genere.id), id: \.id){ movie in
                            NavigationLink(
                                destination: MovieDetail(movie: movie, viewModel: viewModel) ,
                                label: {
                                    LazyVStack(spacing: 1) {
                                        Image(uiImage: "https://image.tmdb.org/t/p/w500\(movie.posterPath)".load())
                                            .resizable()
                                            .frame(width: 100, height: 150, alignment: .center)
                                        Text(movie.originalTitle).font(.title).lineLimit(0)
                                    }
                                }
                            )
                        }
                    }
                }
            }
        }.onAppear{
            self.viewModel.fetchGenreMovies(region: laRegion)
            self.viewModel.fetchRegion(region: laRegion)
        }
    }
}

struct MoviesRegionList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesRegionList(viewModel: MoviesViewModel(), laRegion: "MX")
    }
}

