//
//  TVShowList.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowList: View {
    @ObservedObject var viewModel : TVShowViewModel = TVShowViewModel()
    
    var body: some View {
        TabView {
            List {
                ForEach(self.viewModel.tvShows, id: \.id) { item in
                    NavigationLink(
                        destination: TVShowsDetail(tvShow: item, viewModel: viewModel) ,
                        label: {
                            Text(item.originalName)
                        })
                }
            }
            .onAppear {
                viewModel.fetchTVShows()
            }
            .overlay(Group {
                if self.viewModel.tvShows.isEmpty {
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
    }
}
