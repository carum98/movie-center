//
//  TVShowList.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowList: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Favoritos.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Favoritos.nombre, ascending: true)],
        predicate: NSPredicate(format: "tipo == %@", "TV")
    )var items: FetchedResults<Favoritos>
    
    var body: some View {
        TabView {
            List {
                ForEach(viewModel.tvShows, id: \.id) { item in
                    NavigationLink(
                        destination: TVShowsDetail(tvShow: item, favorito: false),
                        label: {
                            Text(item.originalName)
                        })
                }
            }
            .onAppear {
                if (viewModel.tvShows.isEmpty) {
                    viewModel.fetchTVShows()
                }
            }
            .overlay(Group {
                if viewModel.tvShows.isEmpty {
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
            
            Text("Ubicacion")
            .tabItem {
                Label("Ubicacion", systemImage: "network")
            }
        }
        .navigationBarTitle("Series")
    }
    
    func deleteMovie(at offsets: IndexSet) {
      offsets.forEach { index in
        let movie = self.items[index]
        PersistanceController.shared.eliminar(movie)
      }
    }
}

struct TVShowList_Previews: PreviewProvider {
    static var previews: some View {
        TVShowList()
            .environmentObject(TVShowViewModel())
    }
}
