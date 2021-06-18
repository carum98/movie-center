//
//  MoviesList.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import SwiftUI

struct MoviesList: View {
    @ObservedObject var viewModel : MoviesViewModel = MoviesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.movies, id: \.id) { item in
                    NavigationLink(
                        destination: MovieDetail(movie: item) ,
                        label: {
                            Text(item.original_title)
                        })
                }
            }
            .navigationBarTitle("Lista de peliculas")
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}