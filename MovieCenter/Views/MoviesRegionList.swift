import SwiftUI

struct MoviesRegionList: View {
    var viewModel : MoviesViewModel
    var laRegion:String
    var generos:[Genre]
    var peliculas:[Movies]
    func GetData(){
        self.viewModel.fetchGenreMovies()
        self.viewModel.fetchRegion(region: "CR")
    }
    func ObtengaLasPeliculasPorGenero(lasPelicula:[Movies], genero:Int) -> [Movies]{
        let peliculas:[Movies] = lasPelicula.filter({ (movie) -> Bool in
            if(movie.generes.contains(genero)){
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
                    var lasPeliculas:[Movies] = ObtengaLasPeliculasPorGenero(lasPelicula: peliculas,genero: genere.id)
                    if (lasPeliculas.count > 0){
                        VStack(alignment: .leading, spacing: 6) {
                        Text(genere.name).font(.title).frame(alignment: .leading)
                        //Section(header: Text(genere.name).font(.title)) {
                            ScrollView(.horizontal){
                                LazyHStack(spacing: 20) {
                                    ForEach(lasPeliculas, id: \.id){ movie in
                                        NavigationLink(
                                            destination: MovieDetail(movie: movie, viewModel: viewModel) ,
                                            label: {
                                                LazyVStack(spacing: 1) {
                                                    Image(uiImage: "https://image.tmdb.org/t/p/w500\(movie.posterPath)".load())
                                                        .resizable()
                                                        .frame(width: 100, height: 150, alignment: .center)
//                                                    Text(movie.originalTitle).font(.title).lineLimit(0)
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

struct MoviesRegionList_Previews: PreviewProvider {
    static var previews: some View {
        let theMovies = [
            Movies(id: 1,
                   originalTitle: "Cruella",
                   overview: "\"Cruella\" se sumerge en la juventud rebelde de uno de los villanos más conocidos -y más de moda-, nada menos que la legendaria Cruella de Vil. Emma Stone encarna a Estella, alias Cruella, junto a Emma Thompson como la Baronesa, la directora de una prestigiosa firma de moda que convierte a Estella en una incipiente diseñadora. La cinta está ambientada en el contexto del punk-rock londinense de los 70.  ( https://stream4k.xyz/en/movie/337404/cruella )",
                   backdropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg",
                   posterPath: "/qb28nkLZV0v6yJZZRpJYl0LE35N.jpg", generes: [1,2]),
            Movies(id: 1,
                   originalTitle: "Cruella",
                   overview: "\"Cruella\" se sumerge en la juventud rebelde de uno de los villanos más conocidos -y más de moda-, nada menos que la legendaria Cruella de Vil. Emma Stone encarna a Estella, alias Cruella, junto a Emma Thompson como la Baronesa, la directora de una prestigiosa firma de moda que convierte a Estella en una incipiente diseñadora. La cinta está ambientada en el contexto del punk-rock londinense de los 70.  ( https://stream4k.xyz/en/movie/337404/cruella )",
                   backdropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg",
                   posterPath: "/qb28nkLZV0v6yJZZRpJYl0LE35N.jpg", generes: [1,2]),
            Movies(id: 1,
                   originalTitle: "Cruella",
                   overview: "\"Cruella\" se sumerge en la juventud rebelde de uno de los villanos más conocidos -y más de moda-, nada menos que la legendaria Cruella de Vil. Emma Stone encarna a Estella, alias Cruella, junto a Emma Thompson como la Baronesa, la directora de una prestigiosa firma de moda que convierte a Estella en una incipiente diseñadora. La cinta está ambientada en el contexto del punk-rock londinense de los 70.  ( https://stream4k.xyz/en/movie/337404/cruella )",
                   backdropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg",
                   posterPath: "/qb28nkLZV0v6yJZZRpJYl0LE35N.jpg", generes:[1,2])
        ]
        MoviesRegionList(viewModel: MoviesViewModel(), laRegion: "MX",generos:[Genre(id: 1,name: "Uno"),Genre(id: 2,name: "dos"),Genre(id: 3,name: "tres")], peliculas:theMovies)
    }
}

