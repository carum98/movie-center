//
//  MoviesList.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import SwiftUI

struct MoviesList: View {
    @ObservedObject var viewModel : MoviesViewModel = MoviesViewModel()
    @ObservedObject var Location : LocationViewModel = LocationViewModel()
  
    func goToRegionList() {
        viewModel.fetchRegion(region: Location.region!)
     
    }
    var body: some View {
        TabView {
            List {
                ForEach(self.viewModel.movies, id: \.id) { item in
                    NavigationLink(
                        destination: MovieDetail(movie: item, viewModel: viewModel) ,
                        label: {
                            Text(item.originalTitle)
                        })
                }
            }
            .onAppear {
                viewModel.fetchMovies()
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
            
            Text("Ubicacion")
                .onAppear{
                    self.Location.$region.sink(
                    receiveValue: {_ in
                        goToRegionList()
                    })

                   
                
                }
            .tabItem {
                Label("Ubicacion", systemImage: "network")
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
