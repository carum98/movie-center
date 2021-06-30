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
            Button(action: {
                if(!name.isEmpty){
                    self.msn = "No encuentra el titulo que está buscando"
                    viewModel.fetchSearchTv(name: name)
                }else {
                   noEncontrado=true
                    self.msn = "Debe digitar un nombre para poder buscar"
                }
            }){
                Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundColor(.white)
              }
            Button(action: {
                viewModel.fetchTVShows()
            }) {
                HStack(spacing: 10) {
                Image(systemName: "gobackward")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                }
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
            }.overlay(Group {
                if (self.viewModel.cargando)  {
                    Loading().frame(width: 50, height: 75, alignment: .center)
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
                    FavoriteTVShow(items: items)
                }
            }
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }
            ScrollView(.vertical){
                TvShowRows(laRegion: Location.region,
                       generos: viewModel.genres,
                       series:viewModel.tvShows,
                       favoritos: false)
            }
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
