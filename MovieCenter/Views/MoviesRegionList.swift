import SwiftUI

struct MoviesRegionList: View {
    var movies:[Movies]
    var viewModel : MoviesViewModel
    let columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16)
    ]
    var elements = 1...500
    let gridItem = [GridItem(.fixed(40))]
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 16,
            pinnedViews: [.sectionHeaders, .sectionFooters]
        ) {
            ForEach(0...movies.count-1, id: \.self) { index in
                NavigationLink(
                    destination: MovieDetail(movie: movies[index], viewModel: viewModel) ,
                    label: {
                        LazyVStack(spacing: 1) {
                            Image(uiImage: "https://image.tmdb.org/t/p/w500\(movies[index].posterPath)".load())
                                .resizable()
                                .frame(width: 100, height: 150, alignment: .center)
                            Text(movies[index].originalTitle)
                        }
                    }
                )
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
                   posterPath: "/qb28nkLZV0v6yJZZRpJYl0LE35N.jpg"),
            Movies(id: 1,
                   originalTitle: "Cruella",
                   overview: "\"Cruella\" se sumerge en la juventud rebelde de uno de los villanos más conocidos -y más de moda-, nada menos que la legendaria Cruella de Vil. Emma Stone encarna a Estella, alias Cruella, junto a Emma Thompson como la Baronesa, la directora de una prestigiosa firma de moda que convierte a Estella en una incipiente diseñadora. La cinta está ambientada en el contexto del punk-rock londinense de los 70.  ( https://stream4k.xyz/en/movie/337404/cruella )",
                   backdropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg",
                   posterPath: "/qb28nkLZV0v6yJZZRpJYl0LE35N.jpg"),
            Movies(id: 1,
                   originalTitle: "Cruella",
                   overview: "\"Cruella\" se sumerge en la juventud rebelde de uno de los villanos más conocidos -y más de moda-, nada menos que la legendaria Cruella de Vil. Emma Stone encarna a Estella, alias Cruella, junto a Emma Thompson como la Baronesa, la directora de una prestigiosa firma de moda que convierte a Estella en una incipiente diseñadora. La cinta está ambientada en el contexto del punk-rock londinense de los 70.  ( https://stream4k.xyz/en/movie/337404/cruella )",
                   backdropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg",
                   posterPath: "/qb28nkLZV0v6yJZZRpJYl0LE35N.jpg")
        ]
        MoviesRegionList(movies:theMovies, viewModel: MoviesViewModel())
    }
}

