//
//  TVShowList.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowList: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    @ObservedObject var Location : LocationViewModel = LocationViewModel()
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Favoritos.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Favoritos.nombre, ascending: true)],
        predicate: NSPredicate(format: "tipo == %@", "TV")
    )var items: FetchedResults<Favoritos>
    @State var name:String = ""
    @State var noEncontrado:Bool=false
    var body: some View {
        HStack{
            TextField("Buscar...", text: $name)
            Button {
                viewModel.fetchSearchTv(name: name)
            } label: {
                Text("Consultar")
            }
        }
        TabView {
            ScrollView(.vertical){
                TvShowRows(laRegion: Location.region,
                       generos: viewModel.genres,
                       series:viewModel.tvShows,
                       favoritos: false)
            }.alert(isPresented: self.$noEncontrado, content: {
                Alert(title: Text("No encuentra el titulo que está buscando"))
            })
            .onAppear {
                if (viewModel.tvShows.isEmpty) {
                    viewModel.fetchTVShows()
                }
                if (viewModel.genres.isEmpty) {
                    viewModel.fetchGenreTVShow()
                }
                if (viewModel.regionTV.isEmpty) {
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
            
            List{
                let tvShowFav = viewModel.tvShows.filter { TVShow in
                    return (
                        items.contains(where: {
                            favoritnuevo in if(favoritnuevo.id == TVShow.id){
                                return true
                            }
                            return false
                        })
                    )
                    
                }
//                TvShowRows(laRegion: Location.region,
//                       generos: viewModel.genres,
//                       series: tvShowFav,
//                       favoritos: false)
                ForEach(tvShowFav, id: \.id) { item in
                    NavigationLink(
                        destination: TVShowsDetail(tvShow: item, favorito: false),
                        label: {
                            Text(item.originalName)
                        })
                }
                .onDelete(perform: deleteMovie)
            }
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }
            
            TvShowRows(laRegion: Location.region,
                   generos: viewModel.genres,
                   series:viewModel.tvShows,
                   favoritos: false)
            .tabItem {
                Label("Ubicacion", systemImage: "network")
            }
        }.onChange(of: self.viewModel.noEncontrada, perform: { Equatable in
            noEncontrado = Equatable
        })
        .navigationBarTitle("Series")
    }
    
    func deleteMovie(at offsets: IndexSet) {
      offsets.forEach { index in
        let tvShow = self.items[index]
        PersistanceController.shared.eliminarFavoritoEspecifico(id: tvShow.id)
      }
    }
}

struct TVShowList_Previews: PreviewProvider {
    static var previews: some View {
        TVShowList()
            .environmentObject(TVShowViewModel())
    }
}
