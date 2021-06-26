import SwiftUI

struct MoviesList: View {
    @EnvironmentObject var viewModel : MoviesViewModel
    @ObservedObject var Location : LocationViewModel = LocationViewModel()
    let items = PersistanceController.shared.obtenerFavoritos(tipo: "MV")
    func goToRegionList() {
        viewModel.fetchRegion(region: Location.region)
    }
    var body: some View {
        TabView {
            MoviesRegionList(viewModel: self.viewModel, laRegion:Location.region, generos: viewModel.genres, peliculas: viewModel.movies)
                .onAppear {
                    if (viewModel.movies.isEmpty) {
                        viewModel.fetchMovies()
                    }
                    viewModel.fetchGenreMovies()
                    viewModel.fetchRegion(region: Location.region)
                }
                .overlay(Group {
                    if self.viewModel.movies.isEmpty {
                        Loading()
                    }
                })
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
                        
            List{
                ForEach(items!, id: \.self){ item in
                    Text((item.value(forKey: "nombre") as? String) ?? "")
                }
                .onDelete(perform: deleteMovie)
            }
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }
            
            MoviesRegionList(viewModel: self.viewModel, laRegion:Location.region,generos: viewModel.genres, peliculas: viewModel.regionMovies)
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
        let movie = self.items![index]
        print(movie)
        PersistanceController.shared.eliminar(movie)
      }
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}
