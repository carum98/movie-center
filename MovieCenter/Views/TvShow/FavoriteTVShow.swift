import SwiftUI

struct FavoriteTVShow: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    @State var tvShowFav:[TVShow]=[TVShow]()
    var items:FetchedResults<Favoritos>
    var body: some View {
        List{
            ForEach(tvShowFav, id: \.id) { item in
            HStack{
                Image(uiImage: "https://image.tmdb.org/t/p/w200\(item.posterPath ?? "")".load())
                    .resizable()
                    .frame(width: 50, height: 75, alignment: .center)
                    .cornerRadius(20)
                NavigationLink(
                    destination: TVShowsDetail(tvShow: item, favorito: false),
                    label: {
                        Text(item.originalName)
                    }
                )
            }
            
        }
        .onDelete(perform: deleteMovie)
        }.onAppear {
            obtengaLosFavoritos()
        }
    }
     func obtengaLosFavoritos(){
        tvShowFav = viewModel.tvShows.filter { TVShow in
            return (
                items.contains(where: {
                    favoritnuevo in if(favoritnuevo.id == TVShow.id){
                        return true
                    }
                    return false
                })
            )
            
        }
    }
    func deleteMovie(at offsets: IndexSet) {
      offsets.forEach { index in
        let tvShow = self.tvShowFav[index]
        PersistanceController.shared.eliminarFavoritoEspecifico(id: Int32(tvShow.id))
      }
    }
}


