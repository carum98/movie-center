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
    @State var noEncontrado:Bool=false
    @State var msn : String = "No encuentra el titulo que está buscando"
    var body: some View {
        HStack{
            TextField("Buscar...", text: $name)
            Button {
                if(!name.isEmpty){
                    self.msn = "No encuentra el titulo que está buscando"
                    viewModel.fetchSearch(name: name)
                }else {
                   noEncontrado=true
                    self.msn = "Debe digitar un nombre para poder buscar"
                }
               
            } label: {
                Text("Consultar")
            }
            Button {
                viewModel.fetchMovies()                
            } label: {
                Text("Refrescar")
            }
        }
        TabView {
            List{
                ScrollView(.vertical){
                    MoviesRegionList(viewModel: self.viewModel, laRegion:Location.region, generos: viewModel.genres, peliculas: viewModel.movies,favoritos: false)
                }
            }.alert(isPresented: self.$noEncontrado, content: {
                Alert(title: Text(msn))
            })
            .onAppear {
                if (viewModel.movies.isEmpty) {
                    viewModel.fetchMovies()
                }else{
                    self.viewModel.cargando = false
                }
                
                if (viewModel.genres.isEmpty) {
                    viewModel.fetchGenreMovies()
                }
                if (viewModel.regionMovies.isEmpty) {
                    viewModel.fetchRegion(region: Location.region)
                }
            }
            .overlay(Group {
                if(self.viewModel.cargando){
                    Loading()
                }
            })
            .tabItem {
                Label("List", systemImage: "list.dash")
            }
            
            Group{
                if(items.count == 0){
                    VStack {
                    Text("No hay favoritos")
                  }
                } else {
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
                            HStack{
                                Image(uiImage: "https://image.tmdb.org/t/p/w200\(item.posterPath ?? "")".load())
                                    .resizable()
                                    .frame(width: 50, height: 75, alignment: .center)
                                    .cornerRadius(20)
                                NavigationLink(
                                    destination: MovieDetail(movie: item, favorito: false),
                                    label: {
                                        Text(item.originalTitle)
                                    })
                            }
                            
                        }
                        .onDelete(perform: deleteMovie)
                    }
                }
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
        }.onChange(of: self.viewModel.noEncontrada, perform: { Equatable in
            noEncontrado = Equatable
        })
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
