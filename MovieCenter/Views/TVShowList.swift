//
//  TVShowList.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowList: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    
    var body: some View {
        TabView {
            List {
                ForEach(viewModel.tvShows, id: \.id) { item in
                    NavigationLink(
                        destination: TVShowsDetail(tvShow: item),
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
            
            
            Text("Lista Favoritos")
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
}

struct TVShowList_Previews: PreviewProvider {
    static var previews: some View {
        TVShowList()
            .environmentObject(TVShowViewModel())
    }
}
