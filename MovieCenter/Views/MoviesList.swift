import SwiftUI

struct MoviesList: View {
    @EnvironmentObject var viewModel : MoviesViewModel
    @ObservedObject var Location : LocationViewModel = LocationViewModel()
    //let items = PersistanceController.shared.obtenerFavoritos(tipo: "MV")
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Favoritos.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Favoritos.nombre, ascending: true)],
        predicate: NSPredicate(format: "tipo == %@", "MV")
    )var items: FetchedResults<Favoritos>
    @State var name:String = ""
    var body: some View {
        HStack{
            TextField("Buscar...", text: $name)
            Button {
                viewModel.fetchSearch(name: name)
            } label: {
                Text("Consultar")
            }
        }
        TabView {
            List{
                ScrollView(.vertical){
                    MoviesRegionList(viewModel: self.viewModel, laRegion:Location.region, generos: viewModel.genres, peliculas: viewModel.movies,favoritos: false)
                }
            }
            .onAppear {
                if (viewModel.movies.isEmpty) {
                    viewModel.fetchMovies()
                }
                viewModel.fetchGenreMovies()
                viewModel.fetchRegion(region: Location.region)
            }
            .overlay(Group {
                if self.viewModel.cargando {
                    Loading()
                }
                if !self.viewModel.encontrada {
                        
                }
            })
            .tabItem {
                Label("List", systemImage: "list.dash")
            }
            
            List{
                let movieFav = viewModel.movies.filter { movie in
                    return (
                        items.contains(where: {
                            newMovieFav in if(newMovieFav.id == movie.id){
                                return true
                            }
                            return false
                        })
                    )
                    
                }
                ForEach(movieFav, id: \.id) { item in
                    NavigationLink(
                        destination: MovieDetail(movie: item, favorito: false),
                        label: {
                            Text(item.originalTitle)
                        })
                }
                .onDelete(perform: deleteMovie)
            }
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }
            
            MoviesRegionList(viewModel: self.viewModel, laRegion:Location.region,generos: viewModel.genres, peliculas: viewModel.regionMovies,favoritos: false)
                .tabItem {
                    Label("Ubicacion", systemImage: "network")
                        .overlay(Group {
                            if (self.viewModel.regionMovies.isEmpty || self.viewModel.genres.isEmpty){
                                Loading()
                            }
                        })
                }
        }
        .navigationTitle("Peliculas")
    }
    
    func deleteMovie(at offsets: IndexSet) {
        offsets.forEach { index in
            let movie = self.items[index]
            PersistanceController.shared.eliminarFavoritoEspecifico(id: movie.id)
        }
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}
