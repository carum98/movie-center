import SwiftUI

struct MoviesList: View {
    @ObservedObject var viewModel : MoviesViewModel = MoviesViewModel()
    @ObservedObject var Location : LocationViewModel = LocationViewModel()
    
    func goToRegionList() {
        viewModel.fetchRegion(region: Location.region)
    }
    var body: some View {
        TabView {
//            List {
////                ForEach(self.viewModel.movies, id: \.id) { item in
////                    NavigationLink(
////                        destination: MovieDetail(movie: item, viewModel: viewModel) ,
////                        label: {
////                            Text(item.originalTitle)
////                        })
////                }
//                
//            }
            MoviesRegionList(viewModel: self.viewModel, laRegion:Location.region,generos: viewModel.genres, peliculas: viewModel.movies)
            .onAppear {
                viewModel.fetchMovies()
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
            
            
            Text("Lista Favoritos")
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
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}
