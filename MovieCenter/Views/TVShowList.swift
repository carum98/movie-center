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
    @State var msn : String = "No encuentra el titulo que está buscando"
    var body: some View {
        HStack{
            TextField("Buscar...", text: $name)
            Button {
                if(!name.isEmpty){
                    self.msn = "No encuentra el titulo que está buscando"
                    viewModel.fetchSearchTv(name: name)
                }else {
                   noEncontrado=true
                    self.msn = "Debe digitar un nombre para poder buscar"
                }
            } label: {
                Text("Consultar")
            }
            Button {
                viewModel.fetchTVShows()
            } label: {
                Text("Refrescar")
            }
        }
        TabView {
            ScrollView(.vertical){
                TvShowRows(laRegion: Location.region,
                       generos: viewModel.genres,
                       series:viewModel.tvShows,
                       favoritos: false)
            }.alert(isPresented: self.$noEncontrado, content: {
                Alert(title: Text(self.msn))
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
            
            Group{
                if(items.count == 0){
                    VStack {
                    Text("No hay favoritos")
                  }
                } else {
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
                    }
                }
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
